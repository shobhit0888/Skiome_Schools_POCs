import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skiome_schools/global/global.dart';
import 'package:google_fonts/google_fonts.dart';
import '../centresScreens/centres_ui_design_widget.dart';
import '../models/centres.dart';
import '../widgets/my_drawer.dart';
import '../widgets/text_delegate_header_widget.dart';

class HomeScreenForTeachers extends StatefulWidget {
  const HomeScreenForTeachers({super.key});

  @override
  State<HomeScreenForTeachers> createState() => _HomeScreenForTeachersState();
}

class _HomeScreenForTeachersState extends State<HomeScreenForTeachers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
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
        title: const Text(
          "Skiome ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: TextDelegateHeaderWidget(
                  title:
                      "Welcome ${sharedPreferences!.getString("teacherName")}" +
                          "!")),
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Our Centre",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.purpleAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          //query
          //model
          //design widget
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Centres")
                .where("uid",
                    isEqualTo: sharedPreferences!.getString("centreUID"))
                .snapshots(),
            builder: ((context, AsyncSnapshot dataSnapshot) {
              if (dataSnapshot.hasData) {
                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    Centres model = Centres.fromJson(
                        dataSnapshot.data.docs[index].data()
                            as Map<String, dynamic>);
                    return CentresUiDesignWidget(
                      token: 1,
                      model: model,
                    );
                  },
                  itemCount: dataSnapshot.data.docs.length,
                );
              } else {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text("No Data exists."),
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
