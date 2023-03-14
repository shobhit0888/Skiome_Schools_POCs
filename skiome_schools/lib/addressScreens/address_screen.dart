// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:skiome_schools/addressScreens/address_design_widget.dart';
import 'package:skiome_schools/addressScreens/save_new_address_screen.dart';
import 'package:skiome_schools/assistantMethods/address_changer.dart';
import 'package:skiome_schools/global/global.dart';
import 'package:skiome_schools/models/address.dart';
// import 'package:velocity_x/velocity_x.dart';

class AddressScreen extends StatefulWidget {
  String? centreUID;
  double? totalAmount;
  AddressScreen({
    this.centreUID,
    this.totalAmount,
  });

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
          "Skiome Centre",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (c) => SaveNewAddress(
                        centreUID: widget.centreUID.toString(),
                        totalAmount: widget.totalAmount!.toDouble(),
                      )));
        },
        label: const Text("Add New Address"),
        icon: const Icon(Icons.add_location),
      ),
      body: Column(
        children: [
          //query
          //model
          //design
          Consumer<AddressChanger>(
            builder: (context, address, c) {
              return Flexible(
                  child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("UsersSchools")
                    .doc(sharedPreferences!.getString("uid"))
                    .collection("SchoolAddress")
                    .snapshots(),
                builder: (context, AsyncSnapshot dataSnapshot) {
                  if (dataSnapshot.hasData) {
                    if (dataSnapshot.data.docs.length > 0) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return AddressDesignWidget(
                            addressModel: Address.fromJson(
                                dataSnapshot.data.docs[index].data()
                                    as Map<String, dynamic>),
                            index: address.count,
                            value: index,
                            addressId: dataSnapshot.data.docs[index].id,
                            totalAmount: widget.totalAmount,
                            centreUID: widget.centreUID,
                          );
                        },
                        itemCount: dataSnapshot.data.docs.length,
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Center(
                      child: Text("No data exists."),
                    );
                  }
                },
              ));
            },
          )
        ],
      ),
    );
  }
}
