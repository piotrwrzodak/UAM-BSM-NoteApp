import 'package:bsm_noteapp/env/env.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PasswordRepo {
  static const _keyToStorage = "storage-key";
  final _storage = FlutterSecureStorage();
  final _salt = Env.salt;

  // add hashed password to secure-storage
  Future<void> addPasswordToStorage(String password) async {
    Crypt hashed = hashPassword(password);

    await _storage.write(key: _keyToStorage, value: hashed.toString());
  }

  // hash password
  Crypt hashPassword(String password) {
    final hashed = Crypt.sha256(password, rounds: 10000, salt: _salt);
    return hashed;
  }

  Future<bool> comparePasswords(String inputPassword) async {
    final hashedPassword = await _storage.read(key: _keyToStorage);
    final h = Crypt(hashedPassword.toString());

    if (h.match(inputPassword)) {
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> checkIfAlreadyRegistered() async {
    if (await _storage.containsKey(key: _keyToStorage)) {
      return true;
    }
    else {
      return false;
    }
  }

  Future<void> deletePasswordFromStorage() async {
    await _storage.delete(key: _keyToStorage);
  }
}
