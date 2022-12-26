import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

final _auth = FirebaseAuth.instance;
var verificationID = ''.obs;

Future<void> verifyPhoneNumber(String phone) async {
  await _auth.verifyPhoneNumber(
      phoneNumber: '+91$phone',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar("Error", 'The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationID.value = verificationId;
        print("object");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationID.value = verificationId;
        print("Kapil");
      });
  // timeout: Duration(seconds: 30));
}

Future<bool> verifyOTP(String otp) async {
  var credentials = await _auth.signInWithCredential(
      PhoneAuthProvider.credential(
          verificationId: verificationID.value, smsCode: otp));

  return credentials.user != null ? true : false;
}
