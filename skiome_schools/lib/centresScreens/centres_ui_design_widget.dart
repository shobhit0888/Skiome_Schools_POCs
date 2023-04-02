// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_schools/category_Screens/categories_screen.dart';
import 'package:skiome_schools/models/categories.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

import '../models/centres.dart';

class CentresUiDesignWidget extends StatefulWidget {
  Centres? model;
  int? token;
  CentresUiDesignWidget({
    this.model,
    this.token,
  });

  @override
  State<CentresUiDesignWidget> createState() => _CentresUiDesignWidgetState();
}

class _CentresUiDesignWidgetState extends State<CentresUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => CategoriesScreen(
                      token: widget.token,
                      model: widget.model,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2a4371),
                  Color(0xFF131720),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    color: Colors.black26,
                    offset: Offset(
                      0,
                      -3,
                    ))
              ]),
          height: 305,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.model!.photoUrl.toString(),
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      widget.model!.name.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 210.0),
                    child: SmoothStarRating(
                      rating: widget.model!.ratings == null
                          ? 0.0
                          : double.parse(widget.model!.ratings.toString()),
                      allowHalfRating: true,
                      starCount: 5,
                      color: Colors.blueAccent,
                      borderColor: Colors.blueAccent,
                      size: 16,
                    ),
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // Text(
                  //   "Address: ",
                  //   style: TextStyle(
                  //     color: Colors.pinkAccent,
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
