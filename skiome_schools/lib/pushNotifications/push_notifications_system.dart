// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:skiome_schools/functions/functions.dart';

import '../global/global.dart';

class PushNotificationsSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  //notifications arrives/received
  Future whenNotificationReceived(BuildContext context) async {
    //1. Terminated
    //When the app is completely closed and opened directly from the push notification
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
//open app and show notification data
        showNotificationWhenOpenApp(
            remoteMessage.data["schoolOrderId"], context);
      }
    });

    //2.Foreground
    //When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
//open the app - show notification data
        showNotificationWhenOpenApp(
            remoteMessage.data["schoolOrderId"], context);
      }
    });

    //3.Background
    //When the app is in the background and openly directly from the push notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
//directly show notification data
        showNotificationWhenOpenApp(
            remoteMessage.data["schoolOrderId"], context);
      }
    });
  }

  //device recognition token
  Future generateDeviceRecognitionToken() async {
    String? registrationDeviceToken = await messaging.getToken();
    FirebaseFirestore.instance
        .collection("UsersSchools")
        .doc(sharedPreferences!.getString("uid"))
        .update({
      "schoolDeviceToken": registrationDeviceToken,
    });
    messaging.subscribeToTopic("allCentres");
    messaging.subscribeToTopic("allSchools");
  }

  showNotificationWhenOpenApp(schoolOrderId, context) {
    showReusableSnackBar(context,
        "Your Parcel (# $schoolOrderId)has been Shifted successfully by centre");
  }
}
