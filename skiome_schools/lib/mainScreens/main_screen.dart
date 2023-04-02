import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skiome_schools/achievementsScreens/achievements_screen.dart';
import 'package:skiome_schools/centresScreens/home_screen.dart';
import 'package:skiome_schools/clubs_Screens/clubs_screen.dart';
import 'package:skiome_schools/profileScreens/profile_screen.dart';
import 'package:skiome_schools/teachersScreens/teachers_screen.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/my_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final screens = [
    HomeScreen(),
    TeachersScreen(),
    ClubsScreen(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: MyDrawer(),
      // appBar: AppBar(
      //   flexibleSpace: Container(
      //     decoration: const BoxDecoration(
      //         gradient: LinearGradient(
      //       colors: [
      //         Colors.pinkAccent,
      //         Colors.purpleAccent,
      //       ],
      //       begin: FractionalOffset(0.0, 0.0),
      //       end: FractionalOffset(1.0, 0.0),
      //       stops: [0.0, 1.0],
      //       tileMode: TileMode.clamp,
      //     )),
      //   ),
      //   title: Text(
      //     "Skiome ",
      //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      // ),
      // body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: index,
        items: [
          CurvedNavigationBarItem(
              child: Icon(
                Icons.home_outlined,
                color: Colors.grey[300],
              ),
              label: 'Home',
              labelStyle: TextStyle(color: Colors.white70, fontSize: 12)),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.group,
              color: Colors.grey[300],
            ),
            label: 'Teachers',
            labelStyle: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.castle_outlined,
              color: Colors.grey[300],
            ),
            label: 'Clubs',
            labelStyle: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.person_sharp,
              color: Colors.grey[300],
            ),
            label: 'Profile',
            labelStyle: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
        color: Color(0xFF131720),
        height: 50,
        buttonBackgroundColor: Color(0x40131720),
        backgroundColor: Color(0xFF2a4371),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) => setState(() => this.index = index),
        letIndexChange: (index) => true,
      ),
      body: screens[index],
    );
  }
}
