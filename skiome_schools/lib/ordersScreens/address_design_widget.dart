// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skiome_schools/models/address.dart';
import 'package:skiome_schools/ratingScreens/rate_centre_screen.dart';
import 'package:skiome_schools/splashScreen/my_splash_screen.dart';

class AddressDesign extends StatelessWidget {
  Address? model;
  String? orderSatus;
  String? orderId;
  String? centreId;
  String? orderByUser;
  AddressDesign({
    this.model,
    this.orderSatus,
    this.orderId,
    this.centreId,
    this.orderByUser,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Shipping Details",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(children: [
                const Text(
                  "Name",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  model!.name.toString(),
                  style: TextStyle(color: Colors.grey),
                )
              ]),
              TableRow(children: [
                SizedBox(
                  height: 2,
                ),
                SizedBox(
                  height: 2,
                )
              ]),
              TableRow(children: [
                const Text(
                  "Phone Number",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  model!.phoneNumber.toString(),
                  style: TextStyle(color: Colors.grey),
                )
              ])
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model!.completeAddress.toString(),
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (orderSatus == "normal") {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => MySplashScreen()));
            } else if (orderSatus == "shifted") {
              //implement Parcel received feature
              FirebaseFirestore.instance
                  .collection("Orders")
                  .doc(orderId)
                  .update({
                "status": "ended",
              }).whenComplete(() {
                FirebaseFirestore.instance
                    .collection("UsersSchools")
                    .doc(orderByUser)
                    .collection("Orders")
                    .doc(orderId)
                    .update({
                  "status": "ended",
                });
                //send notification to seller
                Fluttertoast.showToast(msg: "Confirmed Successfully");
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => MySplashScreen()));
              });
            } else if (orderSatus == "ended") {
              //implement Rate this centre feature
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => RateCentreScreen(
                            centreId: centreId,
                          )));
            } else {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => MySplashScreen()));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
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
              width: MediaQuery.of(context).size.width - 40,
              height: orderSatus == "ended"
                  ? 60
                  : MediaQuery.of(context).size.height * .07,
              child: Center(
                child: Text(
                  orderSatus == "ended"
                      ? "Do you want to Rate this Centre?"
                      : orderSatus == "shifted"
                          ? "Parcel Received, \n Clickn  to Confirm"
                          : orderSatus == "normal"
                              ? "Go Back"
                              : "",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
