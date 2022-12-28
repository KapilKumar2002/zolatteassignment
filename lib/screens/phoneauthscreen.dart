import 'package:flutter/material.dart';
import 'package:zollate/screens/otpscreen.dart';
import 'package:zollate/services/phone_auth_services.dart';

class MobileAuthScreen extends StatefulWidget {
  @override
  _MobileAuthScreenState createState() => _MobileAuthScreenState();
}

class _MobileAuthScreenState extends State<MobileAuthScreen> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Phone Auth'),
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
            Column(children: [
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Center(
                  child: Text(
                    'Phone Authentication',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40, right: 10, left: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Phone Number',
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text('+91'),
                    ),
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: _controller,
                ),
              )
            ]),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await verifyPhoneNumber(_controller.text).whenComplete(() =>
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OTPScreen())));

                  _controller.text = "";
                },
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
