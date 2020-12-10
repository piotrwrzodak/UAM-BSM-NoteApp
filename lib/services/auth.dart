import 'package:bsm_noteapp/repository/keysRepo.dart';
import 'package:bsm_noteapp/repository/noteRepo.dart';
import 'package:bsm_noteapp/repository/passwordRepo.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:pointycastle/api.dart';

class AuthStatus with ChangeNotifier {
  bool loggedIn = false;
  String string = "";

  void toggle() {
    loggedIn = !loggedIn;
    notifyListeners();
  }
}

class Authenticate {

  KeysRepo keysRepo = KeysRepo();
  PasswordRepo passRepo = PasswordRepo();
  NoteRepo noteRepo = NoteRepo();
  
  Future<String> register(String password1, String password2) async {
    if (!await passRepo.checkIfAlreadyRegistered()) {
      if (password1 == password2) {
        if (password1.trim() != '') {
          // hash password and add to secure-storage
          passRepo.addPasswordToStorage(password1);

          // generate rsa keys, and store them encrypted with key generated with hashed password and salt
          AsymmetricKeyPair rsaKeys = await keysRepo.generateKeys();
          final hash = setHash(password1);
          await keysRepo.storePasswordEncryptedKeys(hash, rsaKeys);
          
          return "Registered succesfully!";
        }
        else return "Password can't be empty.";
      }
      else return "Passwords are not equal.";
    }
    else return "You have account.\nTry to log in.";
  }

  Future<bool> login(String password) async {
    if (password.trim() == "") {
      return false;
    }
    if (await passRepo.comparePasswords(password)) {
      return true;
    }
    else return false;
  }

  String setHash(String password) {
    Crypt hash = passRepo.hashPassword(password, 5000);
    return hash.toString();
  }

  Future<void> resetAll() async {
    await keysRepo.clearKeys();
    await passRepo.deletePasswordFromStorage();
    await noteRepo.clearNote();
  }

  Future<void> seeState() async {
    await keysRepo.seeKeys();
    final b = await passRepo.checkIfAlreadyRegistered();
    await noteRepo.seeNote();
    print(b);
  }
}