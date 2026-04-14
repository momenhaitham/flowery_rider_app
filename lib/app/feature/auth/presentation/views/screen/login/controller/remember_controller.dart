import 'package:flutter/cupertino.dart';

class RememberController extends ChangeNotifier {
  bool rememberMe = false;

  void changeRememberMe() {
    rememberMe = !rememberMe;
    notifyListeners();
  }
}
