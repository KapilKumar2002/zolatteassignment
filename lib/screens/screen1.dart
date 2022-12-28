import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zollate/screens/login.dart';
import 'package:zollate/services/google_auth_service.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final user = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () async {
              await FirebaseServices().googleSignOut();
              Get.to(() => LoginScreen());
            },
            icon: Icon(Icons.exit_to_app))
      ]),
    );
  }
}
