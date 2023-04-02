// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/objects.dart';
import 'objects_details_screen.dart';

class ObjectsUiDesignWidget extends StatefulWidget {
  Objects? model;
  int? token;
  ObjectsUiDesignWidget({
    this.model,
    this.token,
  });

  @override
  State<ObjectsUiDesignWidget> createState() => _ObjectsUiDesignWidgetState();
}

class _ObjectsUiDesignWidgetState extends State<ObjectsUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ObjectsDetailsScreen(
                    model: widget.model, token: widget.token)));
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          height: 160,
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
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.model!.thumbnailUrl.toString(),
                    height: 105,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.model!.objectName.toString(),
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  widget.model!.longDescription.toString(),
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
