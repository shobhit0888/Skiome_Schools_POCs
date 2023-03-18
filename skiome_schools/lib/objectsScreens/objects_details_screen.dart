// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cart_stepper/cart_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skiome_schools/assistantMethods/cart_Methods.dart';
import 'package:skiome_schools/widgets/appbar_cart_badge.dart';

import '../global/global.dart';
import '../models/objects.dart';

class ObjectsDetailsScreen extends StatefulWidget {
  Objects? model;
  ObjectsDetailsScreen({
    this.model,
  });

  @override
  State<ObjectsDetailsScreen> createState() => _ObjectsDetailsScreenState();
}

class _ObjectsDetailsScreenState extends State<ObjectsDetailsScreen> {
  int counterLimit = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBarCartBadge(
        centreUID: widget.model!.centreUID.toString(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          int objectCounter = counterLimit;
          List<String> objectsIDsList =
              cartMethods.separateObjectIDsFromUserCartList();
          //1. check if then exist already in cart
          if (objectsIDsList.contains(widget.model!.objectId)) {
            Fluttertoast.showToast(msg: "Object is already in Cart");
          } else {
            //2. add object in cart
            cartMethods.addObjectToCart(
              widget.model!.objectId.toString(),
              objectCounter,
              context,
            );
          }
        },
        label: const Text("Add to cart"),
        icon: Icon(
          Icons.delete_sweep_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.model!.thumbnailUrl.toString()),
            //implement object counter
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: CartStepperInt(
                  count: counterLimit,
                  size: 45,
                  style: CartStepperTheme.of(context).copyWith(
                    activeForegroundColor: Colors.white,
                    activeBackgroundColor: Colors.pinkAccent,
                  ),
                  didChangeCount: (value) {
                    if (value < 1) {
                      Fluttertoast.showToast(
                          msg: "The quantity cannot be less than 1");
                      return;
                    }
                    setState(() {
                      counterLimit = value;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10.0),
              child: Text(
                widget.model!.objectName.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.pinkAccent),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Text(
                widget.model!.longDescription.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.model!.objectPrice.toString() + " Rs.",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.pinkAccent),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 300.0),
              child: Divider(
                height: 1,
                thickness: 2,
                color: Colors.pinkAccent,
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}