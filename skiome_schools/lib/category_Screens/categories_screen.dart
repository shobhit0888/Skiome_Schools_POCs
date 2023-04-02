// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skiome_schools/models/centres.dart';
import 'package:skiome_schools/widgets/text_delegate_header_widget.dart';
// import 'package:velocity_x/velocity_x.dart';

import '../models/categories.dart';
import '../widgets/my_drawer.dart';
import 'categories_ui_design_widget.dart';

class CategoriesScreen extends StatefulWidget {
  Centres? model;
  int? token;
  CategoriesScreen({
    this.model,
    this.token,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131720),

      // drawer: MyDrawer(),
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
          "Skiome Centre",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: TextDelegateHeaderWidget(
                  title: widget.model!.name.toString() + " - Categories")),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
            ),
          ),
          //write   query
          //model
          //design widget
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Centres")
                .doc(widget.model!.uid.toString())
                .collection("ObjectCategories")
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
                    Categories categoriesModel = Categories.fromJson(
                      dataSnapshot.data.docs[index].data()
                          as Map<String, dynamic>,
                    );
                    return CategoriesUiDesignWidget(
                      token: widget.token,
                      model: categoriesModel,
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
