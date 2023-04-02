// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skiome_schools/clubMembersScreen/club_members_ui_design_widget.dart';

import '../models/clubMembers.dart';
import '../models/clubs.dart';

class ClubsDetailsScreen extends StatefulWidget {
  Clubs? model;
  String? schoolUID;
  ClubsDetailsScreen({this.model, this.schoolUID});

  @override
  State<ClubsDetailsScreen> createState() => _ObjectsDetailsScreenState();
}

class _ObjectsDetailsScreenState extends State<ClubsDetailsScreen> {
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
        title: Text(widget.model!.clubName.toString()),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  height: 170,
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
                    // borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        widget.model!.photoUrl.toString(),
                        height: 170,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Club Name: " + widget.model!.clubName.toString(),
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          Text(
                            "Tagline: " + widget.model!.tagline.toString(),
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Objective: " + widget.model!.objective.toString(),
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white70),
                          ),
                          Text(
                            "Category: " + widget.model!.category.toString(),
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white70),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 5, bottom: 15),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(70)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF2a4371),
                        Color(0xFF131720),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )),
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(40))),
                // color: Colors.blueGrey,
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Color(0xFF2a4371),
                        Color(0xFF131720),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )),
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.all(Radius.circular(40))),
                    // color: Colors.blueGrey,
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Clubs Members",
                      style: GoogleFonts.lato(
                          color: Colors.white70,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("UsersSchools")
                .doc(widget.model!.schoolUID)
                .collection("Clubs")
                .doc(widget.model!.clubUID)
                .collection("ClubMembers")
                .orderBy("publishDate", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot dataSnapshot) {
              if (dataSnapshot.hasData) //if categoies exist
              {
                //show categories
                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 2,
                  staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    ClubMembers clubsMemberModel = ClubMembers.fromJson(
                      dataSnapshot.data.docs[index].data()
                          as Map<String, dynamic>,
                    );
                    return ClubsMembersUiDesignWidget(
                      schoolUID: widget.model!.schoolUID,
                      model: clubsMemberModel,
                      context: context,
                    );
                  },
                  itemCount: dataSnapshot.data.docs.length,
                );
              } else {
                //if category does not exist
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      "No Categories exists",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 60;
    Offset controlPoint = Offset(size.width / 2, size.height + curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);

    Path path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
