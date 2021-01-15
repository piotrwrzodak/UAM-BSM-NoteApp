import 'package:bsm_noteapp/repository/keysRepo.dart';
import 'package:bsm_noteapp/repository/noteRepo.dart';
import 'package:bsm_noteapp/repository/passwordRepo.dart';
import 'package:pointycastle/api.dart';

class PasswordAuth {

  KeysRepo keysRepo = KeysRepo();
  PasswordRepo passRepo = PasswordRepo();
  NoteRepo noteRepo = NoteRepo();
  
  Future<String> register(String password1, String password2) async {
    if (!await passRepo.checkIfAlreadyRegistered()) {
      if (password1 == password2) {
        if (password1.trim() != '') {
          
          passRepo.addPasswordToStorage(password1);
          AsymmetricKeyPair rsaKeys = await keysRepo.generateKeys();
          await keysRepo.storeKeys(rsaKeys);
          
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

  Future<void> resetAll() async {
    await keysRepo.clear();
    await passRepo.deletePasswordFromStorage();
    await noteRepo.clearNote();
  }

  // // function for debug
  // Future<void> seeState() async {
  //   await keysRepo.seeKeys();
  //   final b = await passRepo.checkIfAlreadyRegistered();
  //   await noteRepo.seeNote();
  //   print(b);
  // }
}