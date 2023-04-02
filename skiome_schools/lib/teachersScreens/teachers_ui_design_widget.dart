// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_schools/models/teachers.dart';

import '../models/objects.dart';

class TeachersUiDesignWidget extends StatefulWidget {
  Teachers? model;

  TeachersUiDesignWidget({
    this.model,
  });

  @override
  State<TeachersUiDesignWidget> createState() => _ObjectsUiDesignWidgetState();
}

class _ObjectsUiDesignWidgetState extends State<TeachersUiDesignWidget> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: () {
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (c) => TeachersUiDesignWidget(
    //                   model: widget.model,
    //                 )));
    //   },
    // child:
    return Card(
        color: Colors.blueGrey,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: FlipCard(
          fill: Fill
              .fillBack, // Fill the back side of the card to make in the same size as the front.
          direction: FlipDirection.HORIZONTAL, // default
          side: CardSide.FRONT, // The side to initially display.
          front: Container(
            height: 170,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xFF108ca4),
                      Color(0xFF43d0ec),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    "images/avatar.png",
                    height: 100,
                    width: 100,
                  ),
                ),
                Text(
                  widget.model!.teacherName.toString(),
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                )
              ],
            ),
          ),
          back: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xFFa5115b),
                      Color(0xFFef4199),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            height: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(40),
                //   child: Image.network(
                //     widget.model!.thumbnailUrl.toString(),
                //     height: 220,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  widget.model!.teacherName.toString(),
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  widget.model!.teacherEmail.toString(),
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.model!.phoneNumber.toString(),
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.model!.subject.toString(),
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  widget.model!.classes.toString(),
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  "Password: " + widget.model!.password.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ),
        )
        // child: SizedBox(
        //   height: 200,
        //   width: MediaQuery.of(context).size.width,

        );

    // );
  }
}
