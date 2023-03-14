import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:skiome_schools/assistantMethods/cart_object_counter.dart';
import 'package:skiome_schools/global/global.dart';

class CartMethods {
  addObjectToCart(String? objectId, int objectCounter, BuildContext context) {
    //save to Local storage
    List<String>? tempList = sharedPreferences!.getStringList("userCart");
    tempList!.add(
        objectId.toString() + ":" + objectCounter.toString()); //25522544 : 5

//save to Firebase
    FirebaseFirestore.instance
        .collection("UsersSchools")
        .doc(sharedPreferences!.getString("uid"))
        .update({
      "userCart": tempList,
    }).then((value) {
      Fluttertoast.showToast(msg: "Object added successfully");
      //save to local storage
      sharedPreferences!.setStringList("userCart", tempList);

      //update object badge number
      Provider.of<CartObjectCounter>(context, listen: false)
          .showCartListObjectsNumber();
    });
  }

  clearCart(BuildContext context) {
    //clear in the local storage
    sharedPreferences!.setStringList("userCart", ["initalValue"]);
    List<String>? emptyCartList = sharedPreferences!.getStringList("userCart");

    FirebaseFirestore.instance
        .collection("UsersSchools")
        .doc(sharedPreferences!.getString("uid"))
        .update({
      "userCart": emptyCartList,
    }).then((value) {
      //updated object badge number
      Provider.of<CartObjectCounter>(context, listen: false)
          .showCartListObjectsNumber();
    });
  }

//5515123 : 5 => 5515123
  separateObjectIDsFromUserCartList() {
    List<String>? userCartList = sharedPreferences!.getStringList("userCart");

    List<String> objectsIDsList = [];
    for (int i = 1; i < userCartList!.length; i++) {
      //5515123 : 5
      String object = userCartList[i].toString();
      var lastCharacterPositionOfObjectBeforeColon = object.lastIndexOf(":");
      //5515123
      String getObjectID =
          object.substring(0, lastCharacterPositionOfObjectBeforeColon);
      objectsIDsList.add(getObjectID);
    }

    return objectsIDsList;
  }

  //5515123 : 5 => 5
  separateObjectQuantitiesFromUserCartList() {
    List<String>? userCartList = sharedPreferences!.getStringList("userCart");

    List<int> objectsQuantitiesList = [];
    for (int i = 1; i < userCartList!.length; i++) {
      //5515123 : 5
      String object = userCartList[i].toString();
      //:5 like this it will separate
      var colonAfterCharacterList = object.split(":").toList(); //0=[:], 1=[5]
      var quantityNumber = int.parse(colonAfterCharacterList[1].toString());
      //5515123
      // String getObjectID =
      //     object.substring(0, lastCharacterPositionOfObjectBeforeColon);
      objectsQuantitiesList.add(quantityNumber);
    }

    return objectsQuantitiesList;
  }

  separateOrderObjectIDs(productIds) {
    List<String>? userCartList = List<String>.from(productIds);

    List<String> objectsIDsList = [];
    for (int i = 1; i < userCartList.length; i++) {
      //5515123 : 5
      String object = userCartList[i].toString();
      var lastCharacterPositionOfObjectBeforeColon = object.lastIndexOf(":");
      //5515123
      String getObjectID =
          object.substring(0, lastCharacterPositionOfObjectBeforeColon);
      objectsIDsList.add(getObjectID);
    }

    return objectsIDsList;
  }

  separateOrderObjectQuantities(productIds) {
    List<String>? userCartList = List<String>.from(productIds);

    List<String> objectsQuantitiesList = [];
    for (int i = 1; i < userCartList.length; i++) {
      //5515123 : 5
      String object = userCartList[i].toString();
      //:5 like this it will separate
      var colonAfterCharacterList = object.split(":").toList(); //0=[:], 1=[5]
      var quantityNumber = int.parse(colonAfterCharacterList[1].toString());
      //5515123
      // String getObjectID =
      //     object.substring(0, lastCharacterPositionOfObjectBeforeColon);
      objectsQuantitiesList.add(quantityNumber.toString());
    }

    return objectsQuantitiesList;
  }
}
