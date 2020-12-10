import 'dart:convert';
import 'dart:typed_data';

import 'package:bsm_noteapp/repository/keysRepo.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:pointycastle/api.dart';


class NoteRepo {
  static const _keyToStorage = "storage-text-key";
  final KeysRepo keysRepo = KeysRepo();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  

  Future<void> encryptNote(String text, String hash) async {
    AsymmetricKeyPair keys = await keysRepo.retrievePasswordEncryptedKeys(hash);
    final encrypter = Encrypter(RSA(publicKey: keys.publicKey, privateKey: keys.privateKey));
    final encrypted = encrypter.encrypt(text);

    Uint8List encryptionKey = await getKeyToStorage();

    var encryptedBox = await Hive.openBox('vaultBox', encryptionCipher: HiveAesCipher(encryptionKey));
    String toBox = encrypted.base64;
    encryptedBox.put('secret', toBox);
    print('encrypted: ' + encrypted.base64);
  }

  Future<String> decryptNote(String hash) async {
    AsymmetricKeyPair keys = await keysRepo.retrievePasswordEncryptedKeys(hash);
    final encrypter = Encrypter(RSA(publicKey: keys.publicKey, privateKey: keys.privateKey));
     
    Uint8List encryptionKey = await getKeyToStorage();

    var encryptedBox = await Hive.openBox('vaultBox', encryptionCipher: HiveAesCipher(encryptionKey));
    final encryptedText = encryptedBox.get('secret');
    if (encryptedText != null) {
      Encrypted toDecrypt = Encrypted.fromBase64(encryptedText);
      final decrypted = encrypter.decrypt(toDecrypt);
      print('decrypted: ' + decrypted);
      return decrypted;
    }
    else {
      return "Here save your note!";
    }
    
  }

  Future<Uint8List> getKeyToStorage() async {
    var containsEncryptionKey = await secureStorage.containsKey(key: _keyToStorage);
    if (!containsEncryptionKey)  {
      var key = Hive.generateSecureKey();
      await secureStorage.write(key: _keyToStorage, value: base64UrlEncode(key));
    }
    var encryptionKey = base64Url.decode(await secureStorage.read(key: _keyToStorage));

    return encryptionKey;
  }

    Future<void> clearNote() async {
    Uint8List encryptionKey = await getKeyToStorage();
    var encryptedBox = await Hive.openBox('vaultBox', encryptionCipher: HiveAesCipher(encryptionKey));
    encryptedBox.clear();
  }

  Future<void> seeNote() async {
    final encryptionKey = await getKeyToStorage();
    var encryptedBox = await Hive.openBox('vaultBox', encryptionCipher: HiveAesCipher(encryptionKey));
    final encryptedText = encryptedBox.get('secret');
    print('encrypted text');
    print(encryptedText);
  }

}