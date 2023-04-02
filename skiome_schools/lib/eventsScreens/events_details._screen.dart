// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skiome_schools/clubMembersScreen/club_members_screen.dart';

import '../global/global.dart';
import '../models/events.dart';
import '../splashScreen/my_splash_screen.dart';

class EventsDetailsScreen extends StatefulWidget {
  Events? model;
  EventsDetailsScreen({
    this.model,
  });

  @override
  State<EventsDetailsScreen> createState() => _EventsDetailsScreenState();
}

class _EventsDetailsScreenState extends State<EventsDetailsScreen> {
  // deleteEvents() {
  //   FirebaseFirestore.instance
  //       .collection("Centres")
  //       .doc(sharedPreferences!.getString("uid"))
  //       .collection("Events")
  //       .doc(widget.model!.eventUID)
  //       .delete()
  //       .then((value) {
  //     FirebaseFirestore.instance
  //         .collection("Events")
  //         .doc(widget.model!.eventUID)
  //         .delete();
  //     Fluttertoast.showToast(msg: "Events Deleted Successfully");
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (c) => MySplashScreen()));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131720),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xFF131720),
              Color(0xFF2a4371),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: Text(widget.model!.eventName.toString()),
        centerTitle: true,
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: (() {
      //     deleteEvents();
      //     // deleteObject();
      //   }),
      //   label: const Text("Delete this Event"),
      //   icon: Icon(
      //     Icons.add_box_outlined,
      //     color: Colors.white,
      //   ),
      //   backgroundColor: Color(0xFF2a4371),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipPath(
              clipper: CurveClipper(),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                child: Container(
                    // decoration: const BoxDecoration(
                    //     gradient: LinearGradient(
                    //   colors: [
                    //     Color(0xFF4c1ab1),
                    //     Color(0xFF7c42ec),
                    //   ],
                    //   begin: FractionalOffset(0.0, 0.0),
                    //   end: FractionalOffset(1.0, 0.0),
                    //   stops: [0.0, 1.0],
                    //   tileMode: TileMode.clamp,
                    // )),
                    color: Color(0xFF2a4371),
                    height: MediaQuery.of(context).size.height * .5,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(widget.model!.photoUrl.toString())),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 30.0, right: 12),
              child: Text(
                "Event Name :  " + widget.model!.eventName.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10.0, right: 12),
              child: Text(
                "Event Timing    :  " + widget.model!.time.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10.0, right: 12),
              child: Text(
                "Venue                :  " + widget.model!.venue.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: 20,
              ),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Colors.white30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 20.0, right: 12),
              child: Text(
                "Open For       :  " + widget.model!.openFor.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10.0, right: 12),
              child: Text(
                "Organised By    :  " + widget.model!.organiser.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Colors.white30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 20.0),
              child: Text(
                "Description   : ",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 5.0, right: 12),
              child: Text(
                widget.model!.description.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10.0, right: 12),
              child: Text(
                "Registration Process :  " +
                    widget.model!.registration.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Colors.white30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 20.0),
              child: Text(
                "Contact Details     ",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10.0),
              child: Text(
                "Email Id  : " + widget.model!.email.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10.0, bottom: 80),
              child: Text(
                "Phone Number : " + widget.model!.phoneNumber.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
