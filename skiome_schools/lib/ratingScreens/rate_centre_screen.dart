// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skiome_schools/global/global.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

import '../splashScreen/my_splash_screen.dart';

class RateCentreScreen extends StatefulWidget {
  String? centreId;
  RateCentreScreen({
    this.centreId,
  });

  @override
  State<RateCentreScreen> createState() => _RateCentreScreenState();
}

class _RateCentreScreenState extends State<RateCentreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Dialog(
        backgroundColor: Colors.white60,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          margin: EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 22,
              ),
              const Text(
                "Rate this Centre",
                style: TextStyle(
                    fontSize: 22,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 22,
              ),
              Divider(
                height: 4,
                thickness: 4,
              ),
              const SizedBox(
                height: 22,
              ),
              SmoothStarRating(
                rating: countStarsRating,
                allowHalfRating: true,
                starCount: 5,
                color: Colors.purpleAccent,
                borderColor: Colors.purpleAccent,
                size: 46,
                onRatingChanged: (valueOfStarsChoosed) {
                  countStarsRating = valueOfStarsChoosed;
                  if (countStarsRating == 1) {
                    setState(() {
                      titleStarsRating = "Very Bad";
                    });
                  }
                  if (countStarsRating == 2) {
                    setState(() {
                      titleStarsRating = "Bad";
                    });
                  }
                  if (countStarsRating == 3) {
                    setState(() {
                      titleStarsRating = "Good";
                    });
                  }
                  if (countStarsRating == 4) {
                    setState(() {
                      titleStarsRating = "Very Good";
                    });
                  }
                  if (countStarsRating == 5) {
                    setState(() {
                      titleStarsRating = "Excellent";
                    });
                  }
                },
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                titleStarsRating,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("Centres")
                        .doc(widget.centreId)
                        .get()
                        .then((snap) {
                      if (snap.data()!["ratings"] ==
                          null) //centre not rated by any school yet
                      {
                        FirebaseFirestore.instance
                            .collection("Centres")
                            .doc(widget.centreId)
                            .update({
                          "ratings": countStarsRating.toString(),
                        });
                      }
                      //centre has been previously rated
                      else {
                        double pastRatings =
                            double.parse(snap.data()!["ratings"].toString());
                        double newRatings =
                            (pastRatings + countStarsRating) / 2;
                        FirebaseFirestore.instance
                            .collection("Centres")
                            .doc(widget.centreId)
                            .update({
                          "ratings": newRatings.toString(),
                        });
                      }
                      Fluttertoast.showToast(msg: "Rated Successfully");
                      setState(() {
                        countStarsRating = 0.0;
                        titleStarsRating = "";
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => MySplashScreen()));
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purpleAccent,
                      padding: EdgeInsets.symmetric(horizontal: 74)),
                  child: const Text("Submit")),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
