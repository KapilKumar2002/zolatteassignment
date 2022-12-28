import 'package:flutter/material.dart';

class PhoneAuthDone extends StatefulWidget {
  const PhoneAuthDone({super.key});

  @override
  State<PhoneAuthDone> createState() => _PhoneAuthDoneState();
}

class _PhoneAuthDoneState extends State<PhoneAuthDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PhoneAuthDone"),
      ),
    );
  }
}
