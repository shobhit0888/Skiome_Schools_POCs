// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:skiome_schools/assistantMethods/cart_object_counter.dart';
import 'package:skiome_schools/cartScreens/cart_screen.dart';

class AppBarCartBadge extends StatefulWidget with PreferredSizeWidget {
  PreferredSizeWidget? preferredSizeWidget;
  String? centreUID;
  AppBarCartBadge({
    this.preferredSizeWidget,
    this.centreUID,
  });

  @override
  State<AppBarCartBadge> createState() => _AppBarCartBadgeState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => preferredSizeWidget == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}

class _AppBarCartBadgeState extends State<AppBarCartBadge> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      automaticallyImplyLeading: true,
      title: Text(
        "Skiome",
        style: TextStyle(
          fontSize: 20,
          letterSpacing: 3,
        ),
      ),
      centerTitle: true,
      actions: [
        Stack(
          children: [
            IconButton(
                onPressed: () {
                  int objectInCart =
                      Provider.of<CartObjectCounter>(context, listen: false)
                          .count;
                  if (objectInCart == 0) {
                    Fluttertoast.showToast(
                        msg:
                            "Cart is Empty. Please First add some items to cart");
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => CartScreen(
                                  centreUID: widget.centreUID,
                                )));
                  }
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                )),
            Positioned(
                child: Stack(
              children: [
                Icon(
                  Icons.brightness_1,
                  color: Colors.deepPurpleAccent,
                  size: 20,
                ),
                Positioned(
                  top: 2,
                  right: 5,
                  child: Center(
                    child: Consumer<CartObjectCounter>(
                        builder: (context, counter, c) {
                      return Text(
                        counter.count.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      );
                    }),
                  ),
                )
              ],
            ))
          ],
        )
      ],
    );
  }
}
