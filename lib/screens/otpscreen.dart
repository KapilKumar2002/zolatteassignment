import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:zollate/screens/homescreen.dart';
import 'package:zollate/services/phone_auth_services.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool _otpCorrect = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinPutController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  String? otp;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.red, Colors.blue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Pinput(
                key: key,
                validator: MultiValidator([
                  RequiredValidator(errorText: "Otp is not correct"),
                  MinLengthValidator(6, errorText: "Please enter correct otp"),
                ]),
                length: 6,
                defaultPinTheme: defaultPinTheme,
                controller: _pinPutController,
                pinAnimationType: PinAnimationType.fade,
                onChanged: (value) {
                  setState(() {
                    otp = value;
                  });
                },
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  print(otp);
                  try {
                    _otpCorrect = await verifyOTP(otp!);

                    print(_otpCorrect);
                  } on FirebaseAuthException catch (e) {
                    Get.snackbar("Error", "${e.toString()}");
                  }
                  _otpCorrect
                      ? Get.to(() => HomeScreen())
                      : Get.snackbar("Error", "OTP is not correct");
                },
                child: Text("Continue"))
          ],
        ),
      ),
    );
  }
}
