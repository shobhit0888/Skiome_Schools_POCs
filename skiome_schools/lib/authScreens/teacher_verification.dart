import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skiome_schools/global/global.dart';
import 'package:skiome_schools/centresScreens/home_screen.dart';
import 'package:skiome_schools/models/schools.dart';
import 'package:skiome_schools/teachersScreens/home_screen_for_teachers.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/loading_dialog.dart';

class TeachersLoginTabPage extends StatefulWidget {
  const TeachersLoginTabPage({super.key});

  @override
  State<TeachersLoginTabPage> createState() => _TeachersLoginTabPageState();
}

class _TeachersLoginTabPageState extends State<TeachersLoginTabPage> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  validateForm() {
    if (emailTextEditingController.text.isNotEmpty &&
        passwordTextEditingController.text.isNotEmpty) {
      //allow user to login
      loginNow();
    } else {
      Fluttertoast.showToast(msg: "Please provide email and password");
    }
  }

  loginNow() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingDialogWidget(
            meassage: "Checking Credentials",
          );
        });

    User? currentUser;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.trim())
        .then((auth) {
      currentUser = auth.user;
    }).catchError((errorMessage) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occured: \n $errorMessage");
    });

    if (currentUser != null) {
      checkUserRecordExist(currentUser!);
    }
  }

  checkUserRecordExist(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("Teachers")
        .doc(currentUser.uid)
        .get()
        .then((record) async {
      if (record.exists) //record exist
      {
        if (record.data()!["status"] == "approved") {
          await sharedPreferences!
              .setString("teacherUID", record.data()!["teacherUID"]);
          await sharedPreferences!
              .setString("teacherEmail", record.data()!["teacherEmail"]);
          await sharedPreferences!
              .setString("teacherName", record.data()!["teacherName"]);
          await sharedPreferences!
              .setString("schoolUID", record.data()!["schoolUID"]);
          await sharedPreferences!
              .setString("centreUID", record.data()!["centreUID"]);
          // await sharedPreferences!

          // .setString("photoUrl", record.data()!["photoUrl"]);
          List<String> userCartList =
              record.data()!["userCart"].cast<String>();

          await sharedPreferences!
              .setStringList("userCart", userCartList);
          //send the user to homeScreen

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (c) => HomeScreenForTeachers()));
        } else //status is not approved
        {
          FirebaseAuth.instance.signOut();
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg:
                  "You have been BLOCKED by Admin. \n contact Admin : techlead@skiome.in");
        }
      } else //record not exist
      {
        FirebaseAuth.instance.signOut();
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "This record does not exist");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "images/login_image.png",
              height: MediaQuery.of(context).size.height * 0.30,
            ),
          ),
          Form(
            child: Column(
              children: [
                //email
                CustomTextField(
                  textEditingController: emailTextEditingController,
                  iconData: Icons.email,
                  hintText: "Teacher Email",
                  isObscure: false,
                  enabled: true,
                ),
                //password
                CustomTextField(
                  textEditingController: passwordTextEditingController,
                  iconData: Icons.lock,
                  hintText: "Password",
                  isObscure: false,
                  enabled: true,
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 12)),
              onPressed: (() {
                validateForm();
              }),
              child: const Text(
                "LogIn",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
