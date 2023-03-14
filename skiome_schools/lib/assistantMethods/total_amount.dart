import 'package:flutter/cupertino.dart';

class TotalAmount extends ChangeNotifier {
  double totalAmountOfCartObjects = 0;
  double get tAmount => totalAmountOfCartObjects;

  showTotalAmountOfCartObjects(double totalAmount) async {
    totalAmountOfCartObjects = totalAmount;
    await Future.delayed(const Duration(milliseconds: 100), (() {
      notifyListeners();
    }));
  }
}
