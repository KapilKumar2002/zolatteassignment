import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:zollate/screens/screen1.dart';
import 'package:zollate/screens/screen2.dart';
import 'package:zollate/screens/userdata.dart';
import 'package:quiver/iterables.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final _address = TextEditingController();
  final _phone = TextEditingController();
  final _bio = TextEditingController();

  String? Phone;
  String? address;
  String? bio;

  Future<void> addUserEntry() {
    return users.doc(user!.uid).set({
      'uid': user!.uid,
      'full_name': user!.displayName,
      'email': user!.email,
      'image': "+91 ${user!.photoURL}",
      "phoneNumber": Phone,
      "address": address,
      "age": agevalue,
      "bio": bio,
    }).catchError((error) => print("Failed to add user: $error"));
  }

  final user = FirebaseAuth.instance.currentUser;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Validation() {
    if (formkey.currentState!.validate()) {
      return true;
    } else {
      false;
    }
  }

  List age = range(1, 100).toList();

  String? agevalue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.withOpacity(.8),
        elevation: 0,
        title: Text("Homescreen"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(value: 1, child: Text("Screen 1")),
              PopupMenuItem(value: 2, child: Text("Screen 2"))
            ],
            onSelected: (value) {
              if (value == 1) {
                Get.to(() => Screen1());
              } else if (value == 2) {
                Get.to(() => Screen2());
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.red, Colors.blue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Column(
                    children: [
                      user!.phoneNumber == null
                          ? Image.network("${user!.photoURL}")
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      Text("${user!.displayName}"),
                      SizedBox(
                        height: 10,
                      ),
                      Text("${user!.email}"),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Email verified: ${user!.emailVerified}"),
                      UserData()
                    ],
                  ),
                ),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _address,
                        onChanged: (value) {
                          address = value;
                        },
                        validator:
                            RequiredValidator(errorText: "Required field!"),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintText: "Address"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _phone,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        onChanged: (va) {
                          Phone = va;
                        },
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Required field!"),
                          MinLengthValidator(10,
                              errorText: "Please enter correct phone number")
                        ]),
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text("+91"),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintText: "Phone Number"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ageDropDown(),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _bio,
                        minLines: 1,
                        maxLines: 5,
                        onChanged: (value) {
                          bio = value;
                        },
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Required field!"),
                        ]),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: "Bio",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    Validation();
                    if (agevalue != null && formkey.currentState!.validate()) {
                      addUserEntry().whenComplete(() => Get.snackbar("success",
                          "Data added successfully after validation"));
                    } else {
                      Get.snackbar("error", "form is not valid");
                    }
                    _address.text = "";
                    _phone.text = '';
                    _bio.text = "";
                    setState(() {
                      agevalue = null;
                    });
                  },
                  child: Text("Submit"),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      minimumSize: Size(75, 75)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ageDropDown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.red, Colors.blue],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton(
        menuMaxHeight: 250,
        focusColor: Colors.blueGrey,
        dropdownColor: Colors.red.shade100,
        hint: Text("age"),
        underline: SizedBox(),
        value: agevalue,
        onChanged: (val) {
          setState(() {
            agevalue = val.toString();
          });
        },
        items: age.map((e) {
          return DropdownMenuItem(
              value: e.toString(), child: Text(e.toString()));
        }).toList(),
      ),
    );
  }
}
