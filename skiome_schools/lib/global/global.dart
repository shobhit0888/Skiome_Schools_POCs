import 'package:shared_preferences/shared_preferences.dart';

import '../assistantMethods/cart_Methods.dart';

SharedPreferences? sharedPreferences;
final objectsImagesList = [
  "slider/0.jpg",
  "slider/1.jpg",
  "slider/2.jpg",
  "slider/3.jpg",
  "slider/4.jpg",
  "slider/5.jpg",
  "slider/6.jpg",
  "slider/7.jpg",
  "slider/8.jpg",
  "slider/9.jpg",
  "slider/10.jpg",
  "slider/11.jpg",
  "slider/12.jpg",
  "slider/13.jpg",
];

CartMethods cartMethods = CartMethods();

double countStarsRating = 0.0;

String titleStarsRating = "";

String fcmServerToken =
    "key=AAAAcEuH4jc:APA91bHVphDoS2n6iReNBCNXwwQ6U_aT6YvWoWJ_GsBFhNz9vjVh7pFlUdLH1EA0QIJ6ExtybBohkGiVNihj2wnU_2O10MAjkIiDayjsH1y4xorrXDG9Vz-WCYR0sCmNZsxhDluzJSGu";
