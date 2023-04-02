import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skiome_schools/authScreens/auth_screen.dart';
import 'package:skiome_schools/mainScreens/main_screen.dart';
import 'package:skiome_schools/teachersScreens/home_screen_for_teachers.dart';

import '../centresScreens/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  splashScreenTimer() {
    Timer(const Duration(seconds: 2), () {
      User? currentUser = FirebaseAuth.instance.currentUser;
      //user is already logged in
      if (FirebaseAuth.instance.currentUser != null) {
        checkUserRecordExist(currentUser!);
      }
      //user is not logged in
      else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const AuthScreen()));
      }
    });
  }

  checkUserRecordExist(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("UsersSchools")
        .doc(currentUser.uid)
        .get()
        .then((record) async {
      if (record.exists) //record exist
      {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (c) => const MainScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (c) => const HomeScreenForTeachers()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    splashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.pinkAccent,
            Colors.purpleAccent,
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Image.asset("images/welcome.png"),
              ),
              Text(
                "Skiome",
                style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
