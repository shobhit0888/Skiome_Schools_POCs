// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skiome_schools/achievementsScreens/achievements_ui_design_widget.dart';
import 'package:skiome_schools/global/global.dart';


import '../functions/functions.dart';
import '../models/achievements.dart';
import '../models/categories.dart';
import '../widgets/text_delegate_header_widget.dart';

class AchievementsScreen extends StatefulWidget {
  
  AchievementsScreen({
    Key? key,
   
  }) : super(key: key);

  @override
  State<AchievementsScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AchievementsScreen> {
  // getCentreEarningsFromDatabase() {
  //   FirebaseFirestore.instance
  //       .collection("Centres")
  //       .doc(sharedPreferences!.getString("uid"))
  //       .get()
  //       .then((dataSnapshot) {
  //     previousEarnings = dataSnapshot.data()!["earnings"].toString();
  //   }).whenComplete(() {
  //     restrictBlockedCentresFromUsingCentresApp();
  //   });
  // }

  // restrictBlockedCentresFromUsingCentresApp() async {
  //   await FirebaseFirestore.instance
  //       .collection("Centres")
  //       .doc(sharedPreferences!.getString("uid"))
  //       .get()
  //       .then((snapshot) {
  //     if (snapshot.data()!["status"] != "approved") {
  //       showReusableSnackBar(context, "you are blocked by admin.");
  //       showReusableSnackBar(context, "contact admin:  admin2@ishop.com");
  //       FirebaseAuth.instance.signOut();
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (c) => MySplashScreen()));
  //     }
  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   PushNotificationsSystem pushNotificationsSystem = PushNotificationsSystem();
  //   pushNotificationsSystem.whenNotificationReceived(context);
  //   pushNotificationsSystem.generateDeviceRecognitionToken();
  //   getCentreEarningsFromDatabase();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MyDrawer(),
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
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
        centerTitle: true,
       
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              delegate: TextDelegateHeaderWidget(
            title: "Achievments",
          )),

          //write   query
          //model
          //design widget
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("UsersSchools")
                .doc(sharedPreferences!.getString("uid"))
                .collection("Achievements")
                .orderBy("publishDate", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot dataSnapshot) {
              if (dataSnapshot.hasData) //if categoies exist
              {
                //show categories
                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    Achievements achievementsModel = Achievements.fromJson(
                      dataSnapshot.data.docs[index].data()
                          as Map<String, dynamic>,
                    );
                    return AchievementsUiDesignWidget(
                      schoolUID: sharedPreferences!.getString("uid"),
                      model: achievementsModel,
                      context: context,
                    );
                  },
                  itemCount: dataSnapshot.data.docs.length,
                );
              } else {
                //if category does not exist
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text("No Categories exists"),
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
