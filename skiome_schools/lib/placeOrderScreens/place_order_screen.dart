// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skiome_schools/centresScreens/home_screen.dart';
import 'package:skiome_schools/global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skiome_schools/models/objects.dart';

class PlaceOrderScreen extends StatefulWidget {
  String? addressId;
  double? totalAmount;
  // String? centreUID;
  // String? categoryId;
  Objects? model;
  PlaceOrderScreen({
    this.addressId,
    this.totalAmount,
    // this.centreUID,
    // this.categoryId,
    this.model,
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
      "centreUID": widget.model!.centreUID,
      "categoryId": widget.model!.categoryId,
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
        "centreUID": widget.model!.centreUID,
        "categoryId": widget.model!.categoryId,
        "status": "normal",
      }).whenComplete(() {
        cartMethods.clearCart(context);
        //send push notifications to centre about new order which placed by user
        sendNotificationToCentre(widget.model!.centreUID.toString(), orderId);

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

  sendNotificationToCentre(centreUID, orderId) async {
    String centreDeviceToken = "";
    await FirebaseFirestore.instance
        .collection("Centres")
        .doc(centreUID)
        .get()
        .then((snapshot) {
      if (snapshot.data()!["centreDeviceToken"] != null) {
        centreDeviceToken = snapshot.data()!["centreDeviceToken"].toString();
      }
    });
    notificationFormat(
      centreDeviceToken,
      orderId,
      sharedPreferences!.getString("name"),
    );
  }

  notificationFormat(centreDeviceToken, orderId, schoolName) {
    Map<String, String> headerNotification = {
      'Content-Type': 'application/json',
      'Authorization': fcmServerToken,
    };
    Map bodyNotification = {
      'body':
          "Dear Centre Incharge, New Order(# $orderId) has been placed Successfully from user $schoolName. \n Please Check Now",
      'title': "New Order",
    };
    Map dataMap = {
      'click_action': "FLUTTER_NOTIFICATION_CLICK",
      'id': "1",
      "status": "done",
      "schoolOrderId": orderId,
    };
    Map officialNotificationFormat = {
      'notification': bodyNotification,
      'data': dataMap,
      'priority': 'high',
      'to': centreDeviceToken,
    };
    http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotification,
      body: jsonEncode(officialNotificationFormat),
    );
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
                // print(widget.model!.centreUID.toString() + "   maro");
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
