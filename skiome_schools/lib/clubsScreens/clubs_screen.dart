// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:skiome_schools/global/global.dart';
import 'package:skiome_schools/models/teachers.dart';
import 'package:skiome_schools/teachersScreens/teacher_registration_screen.dart';
import 'package:skiome_schools/teachersScreens/teachers_ui_design_widget.dart';

// import 'package:velocity_x/velocity_x.dart';

import '../models/categories.dart';
import '../models/objects.dart';
import '../objectsScreens/objects_ui_design_widget.dart';
import '../widgets/text_delegate_header_widget.dart';

class ClubsScreen extends StatefulWidget {
  @override
  State<ClubsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ClubsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        title: Text(
          "Skiome Centre",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => TeachersRegistrationTabPage())));
              },
              icon: Icon(
                Icons.add_box_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              delegate: TextDelegateHeaderWidget(
            title: " Clubs",
          )),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          //1. query
          //2. model
          //3. ui design widget
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("UsersSchools")
                .doc(sharedPreferences!.getString("uid"))
                .collection("Clubs")
                // .orderBy("publishDate", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot dataSnapshot) {
              if (dataSnapshot.hasData) //if categoies exist
              {
                //show categories
                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 2,
                  staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    Teachers teachersModel = Teachers.fromJson(
                      dataSnapshot.data.docs[index].data()
                          as Map<String, dynamic>,
                    );
                    return TeachersUiDesignWidget(
                      model: teachersModel,
                    );
                  },
                  itemCount: dataSnapshot.data.docs.length,
                );
              } else {
                //if category does not exist
                // Fluttertoast.showToast(msg: "No teacher registered yet");
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      "No Teachers exists",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
