import 'package:bsm_noteapp/services/keysRepo.dart';
import 'package:bsm_noteapp/services/passwordRepo.dart';
import 'package:flutter/material.dart';

class AuthStatus with ChangeNotifier {
  bool loggedIn = false;

  void toggle() {
    loggedIn = !loggedIn;
    notifyListeners();
  }
}

class Authenticate {

  KeysRepo keysRepo = KeysRepo();
  PasswordRepo passRepo = PasswordRepo();
  
  Future<String> register(String password1, String password2) async {
    if (!await passRepo.checkIfAlreadyRegistered()) {
      if (password1 == password2) {
        passRepo.addPasswordToStorage(password1);
        return "Registered succesfully!";
      }
      else {
        return "Passwords are not equal.";
      }
    }
    else {
      return "You have account.\nTry to log in.";
    }    
  }

  Future<bool> login(String password) async {
    if (await passRepo.comparePasswords(password)) {
      return true;
    }
    else {
      return false;
    }
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