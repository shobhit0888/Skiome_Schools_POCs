// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skiome_schools/eventsScreens/events_ui_design_widget.dart';

import '../global/global.dart';
import '../models/events.dart';
import '../widgets/text_delegate_header_widget.dart';

class EventsScreen extends StatefulWidget {
  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
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
        title: Text(
          "Our Centre",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              delegate: TextDelegateHeaderWidget(
            title: "Upcoming Events and Workshops",
          )),

          //1. query
          //2. model
          //3. ui design widget
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Centres")
                .doc(sharedPreferences!.getString("centreUID"))
                .collection("Events")
                .snapshots(),
            builder: (context, AsyncSnapshot dataSnapshot) {
              if (dataSnapshot.hasData) //if categoies exist
              {
                //show categories
                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 2,
                  staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    Events eventsModel = Events.fromJson(
                      dataSnapshot.data.docs[index].data()
                          as Map<String, dynamic>,
                    );
                    return EventsUiDesignWidget(
                      model: eventsModel,
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
