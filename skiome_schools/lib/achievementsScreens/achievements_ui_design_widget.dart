// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_schools/achievementsScreens/achievements_screen.dart';

import '../functions/functions.dart';
import '../global/global.dart';
import '../models/achievements.dart';
import '../models/categories.dart';
import '../objectsScreens/objects_screen.dart';

class AchievementsUiDesignWidget extends StatefulWidget {
  Achievements? model;
  String? schoolUID;
  BuildContext? context;
  AchievementsUiDesignWidget({
    this.schoolUID,
    this.model,
    this.context,
  });

  @override
  State<AchievementsUiDesignWidget> createState() =>
      _CategoriesUiDesignWidgetState();
}

class _CategoriesUiDesignWidgetState extends State<AchievementsUiDesignWidget> {
  // deleteCategory(String categoryId) {
  //   FirebaseFirestore.instance
  //       .collection("UsersSchools")
  //       .doc(sharedPreferences!.getString("uid"))
  //       .collection("Achievements")
  //       .doc(categoryId)
  //       .delete();
  //   showReusableSnackBar(context, "Category Deleted.");

  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (c) => AchievementsScreen()));
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (c) => ObjectsScreen(
        //               model: widget.model,
        //             )));
      },
      child: Card(
        color: Color(0xFF131720),
        elevation: 7,
        shadowColor: Color(0xFF2a4371),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 140,
            width: MediaQuery.of(context).size.width,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    widget.model!.photoUrl.toString(),
                    height: 130,
                    width: MediaQuery.of(context).size.width * 0.30,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Achievement Name: " +
                          widget.model!.achievementName.toString(),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Competition Name: " +
                          widget.model!.competitionName.toString(),
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Awarded By: " + widget.model!.awardedBy.toString(),
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Authorised By: " + widget.model!.authorisedBy.toString(),
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
