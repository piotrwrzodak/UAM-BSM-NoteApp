import 'package:flutter/material.dart';

class AuthStatus with ChangeNotifier {
  bool loggedIn = false;

  void toggle() {
    loggedIn = !loggedIn;
    notifyListeners();
  }
}

class Authenticate {
  
  bool register(String password1, String password2) {
    // if there is no password stored

    // compare strings
    if (password1 == password2) {
      // hash(password)

      // add to secure storage

      return true;
    }

    return false;
  }

  bool login(String password) {
    // hash(password)

    // compare hashed input with stored hashed password
    // if they match
    return true;

    // else return false;
  }

  // void changeNote(String note) {
  //   // encrypt note

  //   // store it
  // }

  // void changePassword(String currentPassword, String currentPasswordRepeated, String newPassword) {
  //   // compare passwords

  //   // check if they are valid

  //   // replace old by hash(newPassword) 
  // }
}