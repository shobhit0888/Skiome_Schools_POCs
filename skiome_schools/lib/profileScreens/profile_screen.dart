import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../global/global.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131720),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 70, bottom: 12),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 130,
                  width: 130,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      sharedPreferences!.getString("photoUrl")!,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: GoogleFonts.lato(
                      color: Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  // style: TextStyle(

                  //     color: Colors.grey,
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
