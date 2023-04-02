// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../functions/functions.dart';
import '../global/global.dart';
import '../models/categories.dart';
import '../models/clubMembers.dart';
import '../objectsScreens/objects_screen.dart';

class ClubsMembersUiDesignWidget extends StatefulWidget {
  ClubMembers? model;
  String? schoolUID;
  BuildContext? context;
  ClubsMembersUiDesignWidget({
    this.schoolUID,
    this.model,
    this.context,
  });

  @override
  State<ClubsMembersUiDesignWidget> createState() =>
      _CategoriesUiDesignWidgetState();
}

class _CategoriesUiDesignWidgetState extends State<ClubsMembersUiDesignWidget> {
  // deleteCategory(String categoryId) {
  //   FirebaseFirestore.instance
  //       .collection("UsersSchools")
  //       .doc(sharedPreferences!.getString("uid"))
  //       .collection("Clubs")
  //       .doc(categoryId)
  //       .delete();
  //   showReusableSnackBar(context, "Category Deleted.");

  //   Navigator.push(context, MaterialPageRoute(builder: (c) => ClubsScreen()));
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.blueGrey,
        elevation: 10,
        child: FlipCard(
          fill: Fill
              .fillBack, // Fill the back side of the card to make in the same size as the front.
          direction: FlipDirection.HORIZONTAL, // default
          side: CardSide.FRONT, // The side to initially display.
          front: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xFF108ca4),
                      Color(0xFF43d0ec),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            height: 170,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    "images/avatar.png",
                    height: 100,
                    width: 100,
                  ),
                ),
                Text(
                  widget.model!.name.toString(),
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                )
              ],
            ),
          ),
          back: Container(
            height: 170,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xFFa5115b),
                      Color(0xFFef4199),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(40),
                //   child: Image.network(
                //     widget.model!.thumbnailUrl.toString(),
                //     height: 220,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  widget.model!.name.toString(),
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  widget.model!.memberPost.toString(),
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.model!.email.toString(),
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.model!.phoneNumber.toString(),
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
              ],
            ),
          ),
        )
        // child: SizedBox(
        //   height: 200,
        //   width: MediaQuery.of(context).size.width,

        );
  }
}
