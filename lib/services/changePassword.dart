import 'package:bsm_noteapp/repository/passwordRepo.dart';

class ChangePassword {

  Future<String> changePassword(String currentPassword, String currentPasswordRepeated, String newPassword) async {
     PasswordRepo passRepo = PasswordRepo();

    if (currentPassword == currentPasswordRepeated) {
      
      if (await passRepo.comparePasswords(currentPassword)) {
        if (newPassword != "") {

          passRepo.deletePasswordFromStorage();
          passRepo.addPasswordToStorage(newPassword);

          return "Password succesfully changed!";
        }
        else return "Password can't be empty!";
      }
      else return "Incorrect password.";
    }
    else return "Passwords don't match.";
  }
}