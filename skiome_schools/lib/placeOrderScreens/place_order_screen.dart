// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skiome_schools/centresScreens/home_screen.dart';
import 'package:skiome_schools/global/global.dart';

class PlaceOrderScreen extends StatefulWidget {
  String? addressId;
  double? totalAmount;
  String? centreUID;
  PlaceOrderScreen({
    this.addressId,
    this.totalAmount,
    this.centreUID,
  });

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  String orderId = DateTime.now().millisecondsSinceEpoch.toString();
  orderDetails() {
    saveOrderDetailsForSchool({
      "addressId": widget.addressId,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIds": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Cash on Delivery",
      "orderTime": orderId,
      "orderId": orderId,
      "isSuccess": true,
      "centreUID": widget.centreUID,
      "status": "normal",
    }).whenComplete(() {
      saveOrderDetailsForCentre({
        "addressId": widget.addressId,
        "totalAmount": widget.totalAmount,
        "orderBy": sharedPreferences!.getString("uid"),
        "productIds": sharedPreferences!.getStringList("userCart"),
        "paymentDetails": "Cash on Delivery",
        "orderTime": orderId,
        "orderId": orderId,
        "isSuccess": true,
        "centreUID": widget.centreUID,
        "status": "normal",
      }).whenComplete(() {
        cartMethods.clearCart(context);
        //send push notifications

        Fluttertoast.showToast(
            msg: "Congratulations, Order has been placed successfully.");
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => HomeScreen()));
        orderId = "";
      });
    });
  }

  saveOrderDetailsForSchool(Map<String, dynamic> orderDetailsMap) async {
    await FirebaseFirestore.instance
        .collection("UsersSchools")
        .doc(sharedPreferences!.getString("uid"))
        .collection("Orders")
        .doc(orderId)
        .set(orderDetailsMap);
  }

  saveOrderDetailsForCentre(Map<String, dynamic> orderDetailsMap) async {
    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(orderId)
        .set(orderDetailsMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/delivery.png"),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
              onPressed: () {
                orderDetails();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: Text("Place Order Now"))
        ],
      ),
    );
  }
}
