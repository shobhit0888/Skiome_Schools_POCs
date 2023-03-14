// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:skiome_schools/addressScreens/address_screen.dart';
import 'package:skiome_schools/assistantMethods/cart_object_counter.dart';
import 'package:skiome_schools/assistantMethods/total_amount.dart';
import 'package:skiome_schools/cartScreens/cart_object_design_widget.dart';
import 'package:skiome_schools/global/global.dart';
import 'package:skiome_schools/models/objects.dart';
import 'package:skiome_schools/splashScreen/my_splash_screen.dart';
import 'package:skiome_schools/widgets/appbar_cart_badge.dart';

class CartScreen extends StatefulWidget {
  String? centreUID;
  CartScreen({
    this.centreUID,
  });
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int>? objectQuantityList;
  double totalAmount = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false)
        .showTotalAmountOfCartObjects(0);
    objectQuantityList = cartMethods.separateObjectQuantitiesFromUserCartList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBarCartBadge(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              cartMethods.clearCart(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => MySplashScreen()));
            },
            heroTag: "btn1",
            icon: Icon(Icons.clear_all),
            label: const Text(
              "Clear Cart",
              style: TextStyle(fontSize: 16),
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => AddressScreen(
                            centreUID: widget.centreUID.toString(),
                            totalAmount: totalAmount.toDouble(),
                          )));
            },
            heroTag: "btn2",
            icon: Icon(Icons.navigate_next),
            label: const Text("Check Out", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: Colors.black54,
              child: Consumer2<TotalAmount, CartObjectCounter>(
                  builder: (context, amountProvider, cartProvider, c) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                    child: cartProvider.count == 0
                        ? Container()
                        : Text(
                            "Total Price: " +
                                (amountProvider.tAmount).toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              fontSize: 22,
                            ),
                          ),
                  ),
                );
              }),
            ),
          ),

          //query
          //model
          //design

          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Objects")
                .where("objectId",
                    whereIn: cartMethods.separateObjectIDsFromUserCartList())
                .orderBy("publishDate", descending: true)
                .snapshots(),
            builder: (context, dataSnapshot) {
              if (dataSnapshot.hasData) {
                //display
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    Objects model = Objects.fromJson(
                        dataSnapshot.data!.docs[index].data()
                            as Map<String, dynamic>);

                    if (index == 0) {
                      totalAmount = 0;
                      totalAmount = totalAmount +
                          (double.parse(model.objectPrice!) *
                              objectQuantityList![index]);
                    } else {
                      totalAmount = totalAmount +
                          (double.parse(model.objectPrice!) *
                              objectQuantityList![index]);
                    }
                    if (dataSnapshot.data!.docs.length - 1 == index) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Provider.of<TotalAmount>(context, listen: false)
                            .showTotalAmountOfCartObjects(totalAmount);
                      });
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CartObjectDesignWidget(
                        model: model,
                        quantityNumber: objectQuantityList![index],
                      ),
                    );
                  },
                  childCount: dataSnapshot.data!.docs.length,
                ));
              } else {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text("No Object exists in cart"),
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
