// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_schools/competitionsScreens/competitions_details._screen.dart';

import '../models/events.dart';

class CompetitionsUiDesignWidget extends StatefulWidget {
  Events? model;
  BuildContext? context;
  CompetitionsUiDesignWidget({
    this.model,
    this.context,
  });

  @override
  State<CompetitionsUiDesignWidget> createState() =>
      _CompetitionsUiDesignWidgetState();
}

class _CompetitionsUiDesignWidgetState
    extends State<CompetitionsUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => CompetitionsDetailsScreen(
                      model: widget.model,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF006494),
                    Color(0xFF0582ca),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: 255,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 2,
                ),
                Text(
                  widget.model!.eventName.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.network(
                    widget.model!.photoUrl.toString(),
                    height: 170,
                    width: MediaQuery.of(context).size.width * .35,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.model!.time.toString(),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.model!.venue.toString(),
                  style: const TextStyle(
                    color: Colors.white70,
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
