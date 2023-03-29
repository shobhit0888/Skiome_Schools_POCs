// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_schools/centresScreens/home_screen.dart';
import 'package:skiome_schools/teachersScreens/teachers_screen.dart';

class TeachersCardWidget extends StatefulWidget {
  @override
  State<TeachersCardWidget> createState() => _OurObjectsCardWidgetState();
}

class _OurObjectsCardWidgetState extends State<TeachersCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => TeachersScreen()));
      },
      child: Card(
        elevation: 15,
        shadowColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: SizedBox(
            height: 170,
            width: MediaQuery.of(context).size.width * 0.45,
            child: Column(
              children: [
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "Teachers",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
                Divider(
                  height: 2,
                  thickness: 2,
                  color: Colors.purpleAccent,
                ),
                const SizedBox(
                  height: 12,
                ),
                Image.asset(
                  "images/welcome.png",
                  height: 130,
                  fit: BoxFit.cover,
                ),

                // Text(
                //   widget.model!.longDescription.toString(),
                //   style: TextStyle(
                //     color: Colors.grey,
                //     fontSize: 14,
                //     letterSpacing: 3,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
