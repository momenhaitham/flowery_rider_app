import 'package:flutter/material.dart';

class UpdateController extends ChangeNotifier {
  bool isUpdate = false;

  void changeIsUpdate(bool val) {
    isUpdate = val;
    notifyListeners();
  }
}
