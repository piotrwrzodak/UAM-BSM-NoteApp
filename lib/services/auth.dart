import 'package:flutter/material.dart';

class AuthStatus with ChangeNotifier {
  bool loggedIn = false;

  void toggle() {
    loggedIn = !loggedIn;
    notifyListeners();
  }
}