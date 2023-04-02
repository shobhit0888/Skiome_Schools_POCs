// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skiome_schools/clubs_Screens/clubs_screen.dart';

import '../clubMembersScreen/club_members_screen.dart';
import '../functions/functions.dart';
import '../global/global.dart';
import '../models/categories.dart';
import '../models/clubs.dart';
import '../objectsScreens/objects_screen.dart';

class ClubsUiDesignWidget extends StatefulWidget {
  Clubs? model;
  String? schoolUID;
  BuildContext? context;
  ClubsUiDesignWidget({
    this.schoolUID,
    this.model,
    this.context,
  });

  @override
  State<ClubsUiDesignWidget> createState() => _CategoriesUiDesignWidgetState();
}

class _CategoriesUiDesignWidgetState extends State<ClubsUiDesignWidget> {
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ClubsDetailsScreen(
                      model: widget.model,
                      schoolUID: widget.schoolUID,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          height: 130,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF4c1ab1),
                    Color(0xFF7c42ec),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Container(
                  height: 90,
                  width: 90,
                  child: Image.network(
                    widget.model!.photoUrl.toString(),
                    height: 170,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 68.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.model!.clubName.toString(),
                      style: GoogleFonts.poppins(
                        color: Colors.grey[300],
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      widget.model!.category.toString(),
                      style: GoogleFonts.poppins(
                        color: Colors.grey[300],
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        letterSpacing: 1,
                      ),
                    )
                  ],
                ),
              ),

              // Divider(
              //   height: 2,
              //   thickness: 2,
              //   color: Colors.purpleAccent,
              // ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
