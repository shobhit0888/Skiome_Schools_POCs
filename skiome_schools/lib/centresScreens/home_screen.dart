import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skiome_schools/achievementsScreens/achievements_card_widget.dart';
import 'package:skiome_schools/centresScreens/centres_ui_design_widget.dart';
import 'package:skiome_schools/clubs_Screens/clubs_card.widget.dart';
import 'package:skiome_schools/competitionsScreens/competitions_card_widget.dart';
import 'package:skiome_schools/eventsScreens/events_card_widget.dart';
import 'package:skiome_schools/functions/functions.dart';
import 'package:skiome_schools/global/global.dart';
import 'package:skiome_schools/models/centres.dart';
import 'package:skiome_schools/models/schools.dart';
import 'package:skiome_schools/pushNotifications/push_notifications_system.dart';
import 'package:skiome_schools/teachersScreens/teacher_card_ui_design_widget.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../splashScreen/my_splash_screen.dart';
import '../widgets/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  int _dataLength = 1;
  int index = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getSliderImageFromDb() async {
    var _fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await _fireStore
        .collection("Centres")
        .doc(sharedPreferences!.getString("centreUID"))
        .collection('Banners')
        .get();
    if (mounted) {
      setState(() {
        _dataLength = snapshot.docs.length;
      });
    }
    return snapshot.docs;
  }

  restrictBlockedSchoolsFromUsingSchoolsApp() async {
    // print("FDSF");
    // print(sharedPreferences!.getString("centreUID"));
    await FirebaseFirestore.instance
        .collection("UsersSchools")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snapshot) {
      if (snapshot.data()!["status"] != "approved") {
        showReusableSnackBar(context, "you are blocked by admin.");
        showReusableSnackBar(context, "contact admin:  admin2@ishop.com");
        FirebaseAuth.instance.signOut();
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MySplashScreen()));
      } else {
        cartMethods.clearCart(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    PushNotificationsSystem pushNotificationsSystem = PushNotificationsSystem();
    pushNotificationsSystem.whenNotificationReceived(context);
    pushNotificationsSystem.generateDeviceRecognitionToken();
    restrictBlockedSchoolsFromUsingSchoolsApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131720),
      // drawer: MyDrawer(),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (c) => MyDrawer()));
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            icon: Image.asset(
              "images/trademark.png",
            )),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xFF131720),
              Color(0xFF2a4371),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: Text(
          "Skiome ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   key: _bottomNavigationKey,
      //   index: index,
      //   items: [
      //     CurvedNavigationBarItem(
      //         child: Icon(
      //           Icons.home_outlined,
      //           color: Colors.grey[600],
      //         ),
      //         label: 'Home',
      //         labelStyle: TextStyle(color: Colors.white70)),
      //     CurvedNavigationBarItem(
      //       child: Icon(
      //         Icons.search,
      //         color: Colors.grey[600],
      //       ),
      //       label: 'Search',
      //       labelStyle: TextStyle(color: Colors.white70),
      //     ),
      //     CurvedNavigationBarItem(
      //       child: Icon(
      //         Icons.chat_bubble_outline,
      //         color: Colors.grey[600],
      //       ),
      //       label: 'Chat',
      //       labelStyle: TextStyle(color: Colors.white70),
      //     ),
      //     CurvedNavigationBarItem(
      //       child: Icon(
      //         Icons.newspaper,
      //         color: Colors.grey[600],
      //       ),
      //       label: 'Feed',
      //       labelStyle: TextStyle(color: Colors.white70),
      //     ),
      //     CurvedNavigationBarItem(
      //       child: Icon(
      //         Icons.perm_identity,
      //         color: Colors.grey[600],
      //       ),
      //       label: 'Personal',
      //       labelStyle: TextStyle(color: Colors.white70),
      //     ),
      //   ],
      //   color: Colors.purpleAccent,
      //   height: 50,
      //   buttonBackgroundColor: Colors.white,
      //   backgroundColor: Colors.transparent,
      //   animationCurve: Curves.easeInOut,
      //   animationDuration: Duration(milliseconds: 400),
      //   onTap: (index) => setState(() => this.index = index),
      //   letIndexChange: (index) => true,
      // ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome ",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 23,
                        ),
                      ),
                      Text(
                        sharedPreferences!.getString("name").toString() + " !!",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, left: 16, bottom: 8),
                  child: Text(
                    "A way to Skill Development and Advanced Learning",
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
          if (_dataLength != 0)
            FutureBuilder(
                future: getSliderImageFromDb(),
                builder: (_,
                    AsyncSnapshot<
                            List<QueryDocumentSnapshot<Map<String, dynamic>>>>
                        snapShot) {
                  return snapShot.data == null
                      ? const SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .24,
                              width: MediaQuery.of(context).size.width * .95,
                              child: CarouselSlider.builder(
                                itemCount: snapShot.data!.length,
                                itemBuilder:
                                    (BuildContext context, index, int) {
                                  DocumentSnapshot<Map<String, dynamic>>
                                      sliderImage = snapShot.data![index];
                                  Map getImage = sliderImage.data()
                                      as Map<dynamic, dynamic>;
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 1.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          getImage['photoUrl'],
                                          fit: BoxFit.fill,
                                        ),
                                      ));
                                },
                                options: CarouselOptions(
                                    height: MediaQuery.of(context).size.height *
                                        0.95,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 0.85,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 4),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 1000),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    // enlargeFactor: 0.3,
                                    scrollDirection: Axis.horizontal,
                                    onPageChanged:
                                        (int i, carouselPageChangedReason) {
                                      setState(() {
                                        _index = i;
                                      });
                                    }),
                                // options: CarouselOptions(
                                //     viewportFraction: 1,
                                //     initialPage: 0,
                                //     autoPlay: true,
                                //     height: 150,
                                //     onPageChanged:
                                //         (int i, carouselPageChangedReason) {
                                //       setState(() {
                                //         _index = i;
                                //       });
                                //     }
                                //     )
                              ),
                            ),
                          ),
                        );
                }),

          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: SizedBox(
          //         height: MediaQuery.of(context).size.height * .28,
          //         width: MediaQuery.of(context).size.width,
          //         child: CarouselSlider(
          // options: CarouselOptions(
          //   height: MediaQuery.of(context).size.height * 0.9,
          //   aspectRatio: 16 / 9,
          //   viewportFraction: 0.8,
          //   initialPage: 0,
          //   enableInfiniteScroll: true,
          //   reverse: false,
          //   autoPlay: true,
          //   autoPlayInterval: Duration(seconds: 2),
          //   autoPlayAnimationDuration: Duration(milliseconds: 800),
          //   autoPlayCurve: Curves.fastOutSlowIn,
          //   enlargeCenterPage: true,
          //   // enlargeFactor: 0.3,
          //   scrollDirection: Axis.horizontal,
          // ),
          //           // items: objectsImagesList.map((index) {
          //           items: objectsImagesList.map((index) {
          //             return Builder(builder: (BuildContext c) {
          //               return Container(
          //                 width: MediaQuery.of(context).size.width,
          //                 margin: EdgeInsets.symmetric(horizontal: 1.0),
          //                 child: ClipRRect(
          //                   borderRadius: BorderRadius.circular(40),
          //                   child: Image.asset(
          //                     index,
          //                     fit: BoxFit.fill,
          //                   ),
          //                 ),
          //               );
          //             });
          //           }).toList(),
          //         )),
          //   ),
          // ),
          //image Slider

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 5),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF2a4371),
                        Color(0xFF131720),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )),
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(30))),
                // color: Colors.blueGrey,
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, top: 12),
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Color(0xFF2a4371),
                        Color(0xFF131720),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )),
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.all(Radius.circular(40))),
                    // color: Colors.blueGrey,
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Our Centre",
                      style: GoogleFonts.lato(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: SizedBox(
          //     height: 8,
          //   ),
          // ),
          //query
          //model
          //design widget
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Centres")
                .where("uid",
                    isEqualTo: sharedPreferences!.getString("centreUID"))
                .snapshots(),
            builder: ((context, AsyncSnapshot dataSnapshot) {
              if (dataSnapshot.hasData) {
                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    Centres model = Centres.fromJson(
                        dataSnapshot.data.docs[index].data()
                            as Map<String, dynamic>);
                    return CentresUiDesignWidget(
                      token: 0,
                      model: model,
                    );
                  },
                  itemCount: dataSnapshot.data.docs.length,
                );
              } else {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text("No Data exists."),
                  ),
                );
              }
            }),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 5),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF2a4371),
                        Color(0xFF131720),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )),
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(40))),
                // color: Colors.blueGrey,
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, top: 12),
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Color(0xFF2a4371),
                        Color(0xFF131720),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )),
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.all(Radius.circular(40))),
                    // color: Colors.blueGrey,
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Features",
                      style: GoogleFonts.lato(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  EventsCardWidget(),
                  CompetitionsCardWidget(),
                  AchievementsCardWidget(),

                  // Row(
                  //   children: [
                  //     TeachersCardWidget(),
                  //     EventsCardWidget(),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     CompetitionsCardWidget(),
                  //     ClubsCardWidget(),
                  //   ],
                  // ),
                  // Row(
                  //   children: [AchievementsCardWidget()],
                  // ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
