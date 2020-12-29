import 'package:flutter/material.dart';

class AuthStatus with ChangeNotifier {
  bool loggedIn = false;
  String string = "";

  void toggle() {
    loggedIn = !loggedIn;
    notifyListeners();
  }
}