import 'package:bsm_noteapp/services/keysRepo.dart';
import 'package:bsm_noteapp/services/passwordRepo.dart';
import 'package:pointycastle/api.dart';

class ChangePassword {

  Future<String> changePassword(String currentPassword, String currentPasswordRepeated, String newPassword) async {
     PasswordRepo passRepo = PasswordRepo();
     KeysRepo keysRepo = KeysRepo();

    if (currentPassword == currentPasswordRepeated) {
      
      if (await passRepo.comparePasswords(currentPassword)) {
        if (newPassword != "") {

          // get rsa keys with hashed old password
          String oldHash = passRepo.hashPassword(currentPassword, 5000).toString();
          AsymmetricKeyPair rsaKeys = await keysRepo.retrievePasswordEncryptedKeys(oldHash);

          // delete old password
          passRepo.deletePasswordFromStorage();

          // add new one
          passRepo.addPasswordToStorage(newPassword);

          // hash rsa keys with new hash
          String newHash = passRepo.hashPassword(newPassword, 5000).toString();
          await keysRepo.storePasswordEncryptedKeys(newHash, rsaKeys);

          return "Password succesfully changed!";
        }
        else return "Password can't be empty!";
      }
      else return "Incorrect password.";
    }
    else return "Passwords don't match.";
  }
}