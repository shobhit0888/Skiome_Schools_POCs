// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:skiome_schools/assistantMethods/address_changer.dart';
import 'package:skiome_schools/models/address.dart';
import 'package:skiome_schools/models/objects.dart';
import 'package:skiome_schools/placeOrderScreens/place_order_screen.dart';

class AddressDesignWidget extends StatefulWidget {
  Address? addressModel;
  int? index;
  int? value;
  String? addressId;
  double? totalAmount;
  // String? centreUID;
  Objects? model;
  AddressDesignWidget({
    this.addressModel,
    this.index,
    this.value,
    this.addressId,
    this.totalAmount,
    // this.centreUID,
    this.model,
  });

  @override
  State<AddressDesignWidget> createState() => _AddressDesignWidgetState();
}

class _AddressDesignWidgetState extends State<AddressDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF2a4371),
      child: Column(
        children: [
          //address info
          Row(
            children: [
              Radio(
                value: widget.value,
                groupValue: widget.index,
                activeColor: Colors.pink,
                onChanged: (val) {
                  //Provider
                  Provider.of<AddressChanger>(context, listen: false)
                      .showSelectedAddress(val);
                },
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            const Text(
                              "Name: ",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.addressModel!.name.toString(),
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const TableRow(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              "Phone Number: ",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.addressModel!.phoneNumber.toString(),
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const TableRow(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              "Full Address: ",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.addressModel!.completeAddress.toString(),
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const TableRow(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          widget.value == Provider.of<AddressChanger>(context).count
              ? ElevatedButton(
                  onPressed: () {
                    //send the user to place order screen
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => PlaceOrderScreen(
                                  addressId: widget.addressId,
                                  totalAmount: widget.totalAmount,
                                  // centreUID: widget.model!.centreUID,
                                  model: widget.model,
                                )));
                  },
                  child: const Text("Proceed"),
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                )
              : Container(),
        ],
      ),
    );
  }
}
