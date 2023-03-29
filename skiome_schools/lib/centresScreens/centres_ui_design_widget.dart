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
      child: Card(
        color: Colors.black54,
        elevation: 20,
        shadowColor: Colors.grey[200],
        child: SizedBox(
          height: 305,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    widget.model!.photoUrl.toString(),
                    height: 250,
                    width: MediaQuery.of(context).size.width * .4,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.model!.name.toString(),
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SmoothStarRating(
                    rating: widget.model!.ratings == null
                        ? 0.0
                        : double.parse(widget.model!.ratings.toString()),
                    allowHalfRating: true,
                    starCount: 5,
                    color: Colors.pinkAccent,
                    borderColor: Colors.pinkAccent,
                    size: 16,
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
