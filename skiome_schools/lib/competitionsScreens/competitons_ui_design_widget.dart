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
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 2,
                ),
                Text(
                  widget.model!.eventName.toString(),
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Image.network(
                  widget.model!.photoUrl.toString(),
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.model!.time.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.model!.venue.toString(),
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
