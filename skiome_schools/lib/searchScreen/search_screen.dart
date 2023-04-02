import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_schools/centresScreens/centres_ui_design_widget.dart';
import 'package:skiome_schools/models/centres.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String centreNameText = "";
  Future<QuerySnapshot>? storesDocumentList;
  initializeSearchingCentres(String textEnteredByUser) async {
    storesDocumentList = FirebaseFirestore.instance
        .collection("Centres")
        .where("name", isGreaterThanOrEqualTo: textEnteredByUser)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
        automaticallyImplyLeading: true,
        title: TextField(
          onChanged: (textEntered) {
            setState(() {
              centreNameText = textEntered;
            });
            initializeSearchingCentres(centreNameText);
          },
          decoration: InputDecoration(
              hintText: "Search Centre here...",
              hintStyle: TextStyle(color: Colors.white60),
              suffixIcon: IconButton(
                onPressed: () {
                  initializeSearchingCentres(centreNameText);
                },
                icon: Icon(Icons.search),
                color: Colors.white,
              )),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: storesDocumentList,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  Centres model = Centres.fromJson(
                      snapshot.data.docs[index].data() as Map<String, dynamic>);
                  return CentresUiDesignWidget(
                    model: model,
                  );
                });
          } else {
            return Center(
              child: Text("No record found"),
            );
          }
        },
      ),
    );
  }
}
