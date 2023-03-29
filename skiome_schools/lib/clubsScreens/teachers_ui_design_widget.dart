// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      color: Colors.purple[800],
      elevation: 10,
      shadowColor: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
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
                  color: Colors.pink[300],
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
                  color: Colors.grey,
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
                  color: Colors.grey,
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
      ),
    );
    // );
  }
}
