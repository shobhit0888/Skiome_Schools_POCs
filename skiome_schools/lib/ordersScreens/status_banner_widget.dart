// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_schools/centresScreens/home_screen.dart';
import 'package:skiome_schools/mainScreens/main_screen.dart';

class StatusBanner extends StatelessWidget {
  bool? status;
  String? orderStatus;
  StatusBanner({
    this.status,
    this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    String? message;
    IconData? iconData;
    status! ? iconData = Icons.done : iconData = Icons.cancel;
    status! ? message = "Successfully" : message = "UnSuccessfully";
    return Container(
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
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(top: 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => MainScreen()));
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            // const SizedBox(
            //   width: 25,
            // ),

            Text(
                orderStatus == "ended"
                    ? "Parcel Delivered $message"
                    : orderStatus == "shifted"
                        ? "Parcel Shifted $message"
                        : orderStatus == "normal"
                            ? "Order Placed $message"
                            : "",
                style: TextStyle(color: Colors.white, fontSize: 18)),
            // const SizedBox(
            //   width: 6,
            // ),
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.green,
              child: Center(
                  child: Icon(
                iconData,
                color: Colors.white,
                size: 16,
              )),
            )
          ],
        ),
      ),
    );
  }
}
