import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skiome_schools/centresScreens/centres_ui_design_widget.dart';
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
      backgroundColor: Colors.black,
      drawer: MyDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.purpleAccent,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
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
      body: CustomScrollView(
        slivers: [
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
                            padding: const EdgeInsets.only(top: 4),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .28,
                              width: MediaQuery.of(context).size.width,
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
                                        borderRadius: BorderRadius.circular(40),
                                        child: Image.network(
                                          getImage['photoUrl'],
                                          fit: BoxFit.fill,
                                        ),
                                      ));
                                },
                                options: CarouselOptions(
                                    height: MediaQuery.of(context).size.height *
                                        0.9,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 0.8,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 2),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
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
              padding: const EdgeInsets.only(left: 60, top: 20, bottom: 10),
              child: Text(
                "Our Centre",
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
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
                  crossAxisCount: 2,
                  staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    Centres model = Centres.fromJson(
                        dataSnapshot.data.docs[index].data()
                            as Map<String, dynamic>);
                    return CentresUiDesignWidget(
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
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      TeachersCardWidget(),
                      EventsCardWidget(),
                    ],
                  ),
                  Row(
                    children: [
                      CompetitionsCardWidget(),
                    ],
                  ),
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
