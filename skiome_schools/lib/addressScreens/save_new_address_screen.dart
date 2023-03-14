// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skiome_schools/addressScreens/text_field_address_widget.dart';
import 'package:skiome_schools/global/global.dart';
// import 'package:velocity_x/velocity_x.dart';

class SaveNewAddress extends StatefulWidget {
  String? centreUID;
  double? totalAmount;
  SaveNewAddress({
    this.centreUID,
    this.totalAmount,
  });

  @override
  State<SaveNewAddress> createState() => _SaveNewAddressState();
}

class _SaveNewAddressState extends State<SaveNewAddress> {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController stateCountry = TextEditingController();
  String completeAddress = "";
  final formKey = GlobalKey<FormState>();
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
          if (formKey.currentState!.validate()) {
            completeAddress = street.text.trim() +
                ", " +
                address1.text.trim() +
                ", " +
                city.text.trim() +
                ", " +
                stateCountry.text.trim();
            FirebaseFirestore.instance
                .collection("UsersSchools")
                .doc(sharedPreferences!.getString("uid"))
                .collection("SchoolAddress")
                .doc(DateTime.now().millisecondsSinceEpoch.toString())
                .set({
              "name": name.text.trim(),
              "phoneNumber": phoneNumber.text.trim(),
              "address1": address1.text.trim(),
              "street": street.text.trim(),
              "city": city.text.trim(),
              "stateCountry": stateCountry.text.trim(),
              "completeAddress": completeAddress,
            }).then((value) {
              Fluttertoast.showToast(
                  msg: "New Shippment Address havs been save");
              formKey.currentState!.reset();
            });
          }
        },
        label: const Text("Save Now"),
        icon: const Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Save New Address",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldAddressWidget(
                      hint: "Name",
                      controller: name,
                    ),
                    TextFieldAddressWidget(
                      hint: "PhoneNumber",
                      controller: phoneNumber,
                    ),
                    TextFieldAddressWidget(
                      hint: "Address1",
                      controller: address1,
                    ),
                    TextFieldAddressWidget(
                      hint: "Street",
                      controller: street,
                    ),
                    TextFieldAddressWidget(
                      hint: "City",
                      controller: city,
                    ),
                    TextFieldAddressWidget(
                      hint: "state/country",
                      controller: stateCountry,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
