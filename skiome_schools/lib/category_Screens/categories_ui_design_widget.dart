// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../models/categories.dart';
import '../objectsScreens/objects_screen.dart';
import '../splashScreen/my_splash_screen.dart';

class CategoriesUiDesignWidget extends StatefulWidget {
  Categories? model;
  int? token;
  BuildContext? context;
  CategoriesUiDesignWidget({
    this.model,
    this.token,
    this.context,
  });

  @override
  State<CategoriesUiDesignWidget> createState() =>
      _CategoriesUiDesignWidgetState();
}

class _CategoriesUiDesignWidgetState extends State<CategoriesUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ObjectsScreen(
                      token: widget.token,
                      model: widget.model,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF006494),
                    Color(0xFF0582ca),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          height: 155,
          width: MediaQuery.of(context).size.width * .4,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.model!.thumbnailUrl.toString(),
                  height: 110,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.model!.categoryName.toString(),
                style: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
