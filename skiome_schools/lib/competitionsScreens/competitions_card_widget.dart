// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skiome_schools/centresScreens/home_screen.dart';
import 'package:skiome_schools/competitionsScreens/competitions_screen.dart';
import 'package:skiome_schools/eventsScreens/events_screen.dart';
import 'package:skiome_schools/teachersScreens/teachers_screen.dart';

class CompetitionsCardWidget extends StatefulWidget {
  @override
  State<CompetitionsCardWidget> createState() => _CompetitionsCardWidgetState();
}

class _CompetitionsCardWidgetState extends State<CompetitionsCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => CompetitionsScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          height: 130,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFFa57310),
                    Color(0xFFedb443),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: ,
            children: [
              const SizedBox(
                width: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  "Competitions",
                  style: GoogleFonts.poppins(
                    color: Colors.grey[300],
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 88.0),
                child: Container(
                  height: 60,
                  child: Image.asset(
                    "images/welcome.png",
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Divider(
              //   height: 2,
              //   thickness: 2,
              //   color: Colors.purpleAccent,
              // ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}