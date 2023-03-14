import 'package:flutter/cupertino.dart';
import 'package:skiome_schools/global/global.dart';

class CartObjectCounter extends ChangeNotifier {
  int CartListObjectCounter =
      sharedPreferences!.getStringList("userCart")!.length - 1;

  int get count => CartListObjectCounter;

  Future<void> showCartListObjectsNumber() async {
    CartListObjectCounter =
        sharedPreferences!.getStringList("userCart")!.length - 1;
    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
