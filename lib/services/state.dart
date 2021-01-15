import 'package:flutter/material.dart';


class AuthStatus with ChangeNotifier {
  bool loggedIn = false;
  String loginMethod = "chooseLogin";
  String string = "";

  void toggle() {
    loggedIn = !loggedIn;
    notifyListeners();
  }

  void setLoginMethod(String method) {
    loginMethod = method;
    notifyListeners();
  }
}

