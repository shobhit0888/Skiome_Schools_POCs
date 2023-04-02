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
  int? token;
  ObjectsDetailsScreen({
    this.model,
    this.token,
  });

  @override
  State<ObjectsDetailsScreen> createState() => _ObjectsDetailsScreenState();
}

class _ObjectsDetailsScreenState extends State<ObjectsDetailsScreen> {
  int counterLimit = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131720),
      appBar: AppBarCartBadge(
          token: widget.token,
          // centreUID: widget.model!.categoryId.toString(),
          model: widget.model),
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
            if (widget.token ==
                0) // it is school, add objects to school cart i.e userCart.
            {
              cartMethods.addObjectToCart(
                widget.model!.objectId.toString(),
                objectCounter,
                context,
              );
            } else {
              cartMethods.addObjectToTeacherCart(
                widget.model!.objectId.toString(),
                objectCounter,
                context,
              );
            }
          }
        },
        label: const Text("Add to cart"),
        icon: Icon(
          Icons.delete_sweep_outlined,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF2a4371),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width,
                child: Image.network(widget.model!.thumbnailUrl.toString())),
            //implement object counter
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: CartStepperInt(
                  count: counterLimit,
                  size: 45,
                  style: CartStepperTheme.of(context).copyWith(
                    activeForegroundColor: Colors.white,
                    activeBackgroundColor: Color(0xFF2a4371),
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
              padding: const EdgeInsets.only(left: 18.0, top: 10.0),
              child: Text(
                widget.model!.objectName.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white70),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 8.0, top: 8.0),
              child: Text(
                widget.model!.longDescription.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.white60),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                widget.model!.objectPrice.toString() + " Rs.",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 300.0),
              child: Divider(
                height: 1,
                thickness: 2,
                color: Colors.blue,
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
