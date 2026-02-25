import 'package:flutter/foundation.dart';

class GenderController extends ChangeNotifier {
  String gender = '';

  void changeGender(String val) {
    gender = val;

    notifyListeners();
  }
}
