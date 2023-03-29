import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skiome_schools/authScreens/registration_tab_page.dart';

import '../centresScreens/home_screen.dart';
import '../functions/functions.dart';
import '../widgets/custom_text_field.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  String email = "";
  String password = "";
  allowAdminToLogin() async {
    if (email.isEmpty && password.isEmpty) {
      showReusableSnackBar(context, "Please provide email & passowrd");
    } else {
      //allow admin to login
      User? currentAdmin;
      
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
             FirebaseFirestore.instance
          .collection("Admins")
          .doc(value.user!.uid)
          .get().then((snapshot) {
        if (snapshot.exists) {
          // FirebaseAuth.instance.signOut();
          // currentAdmin = null;
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => RegistrationTabPage()));
        } else {
          showReusableSnackBar(
              context, "No record found, You are not an Admin");
        }
      });
        currentAdmin = value.user;
      }).catchError((error) {
        showReusableSnackBar(context, "Error Occured: " + error.toString());
      });
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/admin.png"),
                    TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.deepPurpleAccent,
                            width: 2,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white54,
                            width: 2,
                          )),
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.grey),
                          icon: Icon(
                            Icons.email,
                            color: Colors.deepPurpleAccent,
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.deepPurpleAccent,
                            width: 2,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white54,
                            width: 2,
                          )),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          icon: Icon(
                            Icons.email,
                            color: Colors.deepPurpleAccent,
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showReusableSnackBar(
                              context, "Checking credentials,Please wait.....");
                          allowAdminToLogin();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 20),
                          primary: Colors.deepPurpleAccent,
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              letterSpacing: 2),
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
