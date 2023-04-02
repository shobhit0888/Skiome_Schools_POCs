// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../global/global.dart';
import '../models/orders.dart';
import '../ordersScreens/order_card.dart';

// import 'package:velocity_x/velocity_x.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<HistoryScreen> createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen> {
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
        title: Text(
          "Parcels History",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Orders")
            .where("status", isEqualTo: "ended")
            .where("orderBy", isEqualTo: sharedPreferences!.getString("uid"))
            .orderBy("orderTime", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot dataSnapshot) {
          if (dataSnapshot.hasData) {
            //display

            return ListView.builder(
              itemBuilder: (context, index) {
                Orders model = Orders.fromJson(dataSnapshot.data.docs[index]
                    .data() as Map<String, dynamic>);
                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("ObjectCategories")
                      .doc(model.categoryId)
                      .collection("Objects")
                      .where("objectId",
                          whereIn: cartMethods.separateOrderObjectIDs(
                              (dataSnapshot.data.docs[index].data()
                                  as Map<String, dynamic>)["productIds"]))
                      .where("orderBy",
                          whereIn: (dataSnapshot.data.docs[index].data()
                              as Map<String, dynamic>)["uid"])
                      .orderBy("publishDate", descending: true)
                      .get(),
                  builder: (c, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return OrderCard(
                        itemCount: snapshot.data.docs.length,
                        data: snapshot.data.docs,
                        orderId: dataSnapshot.data.docs[index].id,
                        separateQuantitiesList:
                            cartMethods.separateOrderObjectQuantities(
                                (dataSnapshot.data.docs[index].data()
                                    as Map<String, dynamic>)["productIds"]),
                      );
                    } else {
                      return const Center(
                        child: Text("No data exists"),
                      );
                    }
                  },
                );
              },
              itemCount: dataSnapshot.data.docs.length,
            );
          } else {
            return const Center(
              child: Text("No data exists"),
            );
          }
        },
      ),
    );
  }
}
