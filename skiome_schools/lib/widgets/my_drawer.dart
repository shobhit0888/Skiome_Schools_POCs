import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skiome_schools/history/history_screen.dart';
import 'package:skiome_schools/mainScreens/main_screen.dart';
import 'package:skiome_schools/notYetReceivedParcels/not_yet_received_parcels_screen.dart';
import 'package:skiome_schools/centresScreens/home_screen.dart';
import 'package:skiome_schools/global/global.dart';
import 'package:skiome_schools/ordersScreens/orders_screen.dart';
import 'package:skiome_schools/searchScreen/search_screen.dart';
import 'package:skiome_schools/splashScreen/my_splash_screen.dart';
// import 'package:velocity_x/velocity_x.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xDC131720),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: ListView(
          children: [
            //header
            Container(
              padding: const EdgeInsets.only(top: 26, bottom: 12),
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
            // body
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.only(top: 1),
              child: Column(
                children: [
                  const Divider(
                    height: 10,
                    color: Colors.white30,
                    thickness: 1,
                  ),
                  //home
                  ListTile(
                    leading: const Icon(
                      Icons.home,
                      color: Colors.white70,
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => MainScreen()));
                    },
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.white30,
                    thickness: 1,
                  ),
                  //my orders
                  ListTile(
                    leading: const Icon(
                      Icons.reorder,
                      color: Colors.white70,
                    ),
                    title: Text(
                      "My Orders",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => OrdersScreen()));
                    },
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.white30,
                    thickness: 1,
                  ),
                  //not yet received orders
                  ListTile(
                    leading: const Icon(
                      Icons.picture_in_picture_rounded,
                      color: Colors.white70,
                    ),
                    title: Text(
                      "Not yet received orders",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => NotYetReceivedParcelsScreen()));
                    },
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.white30,
                    thickness: 1,
                  ),
                  //history
                  ListTile(
                    leading: const Icon(
                      Icons.access_time,
                      color: Colors.white70,
                    ),
                    title: Text(
                      "History",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => HistoryScreen()));
                    },
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.white30,
                    thickness: 1,
                  ),
                  //search
                  ListTile(
                    leading: const Icon(
                      Icons.search,
                      color: Colors.white70,
                    ),
                    title: Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => SearchScreen()));
                    },
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.white30,
                    thickness: 1,
                  ),
                  //logout
                  ListTile(
                    leading: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white70,
                    ),
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => MySplashScreen()));
                    },
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.white30,
                    thickness: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
