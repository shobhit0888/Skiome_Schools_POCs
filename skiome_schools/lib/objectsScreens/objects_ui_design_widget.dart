// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/objects.dart';
import 'objects_details_screen.dart';

class ObjectsUiDesignWidget extends StatefulWidget {
  Objects? model;

  ObjectsUiDesignWidget({
    this.model,
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
                      model: widget.model,
                    )));
      },
      child: Card(
        color: Colors.black,
        elevation: 10,
        shadowColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    widget.model!.thumbnailUrl.toString(),
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  widget.model!.objectName.toString(),
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  widget.model!.longDescription.toString(),
                  style: TextStyle(
                    color: Colors.grey,
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
