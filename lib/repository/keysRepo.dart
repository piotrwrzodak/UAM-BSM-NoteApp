import 'package:bsm_noteapp/env/env.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:pointycastle/api.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeysRepo {
  static const _encryptedPublicKeyPrefsKey = "encrypted_public_key";
  static const _encryptedPrivateKeyPrefsKey = "encrypted_private_key";
  final _salt = Env.salt;
  final _rsaHelper = RsaKeyHelper();
  final _cryptor = new PlatformStringCryptor();

  void printKeys(AsymmetricKeyPair keyPair) {
    print(_rsaHelper.encodePublicKeyToPemPKCS1(keyPair.publicKey));
    print(_rsaHelper.encodePrivateKeyToPemPKCS1(keyPair.privateKey));
  }

  Future<AsymmetricKeyPair> generateKeys() {
    return _rsaHelper.computeRSAKeyPair(_rsaHelper.getSecureRandom());
  }

  Future<void> storePasswordEncryptedKeys(String password, AsymmetricKeyPair keyPair) async {
    final key = await _cryptor.generateKeyFromPassword(password, _salt);
    
    final publicKeyPem = _rsaHelper.encodePublicKeyToPemPKCS1(keyPair.publicKey);
    final privateKeyPem = _rsaHelper.encodePrivateKeyToPemPKCS1(keyPair.privateKey);
    final encryptedPublicKey = await _cryptor.encrypt(publicKeyPem, key);
    final encryptedPrivateKey = await _cryptor.encrypt(privateKeyPem, key);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_encryptedPublicKeyPrefsKey, encryptedPublicKey);
    await prefs.setString(_encryptedPrivateKeyPrefsKey, encryptedPrivateKey);
  }

  Future<AsymmetricKeyPair<PublicKey, PrivateKey>> retrievePasswordEncryptedKeys(String password) async {
    String publicKeyPem, privateKeyPem;
    final prefs = await SharedPreferences.getInstance();
    final encryptedPublicKey = prefs.getString(_encryptedPublicKeyPrefsKey);
    final encryptedPrivateKey = prefs.getString(_encryptedPrivateKeyPrefsKey);

    final key = await _cryptor.generateKeyFromPassword(password, _salt);

    try {
      publicKeyPem = await _cryptor.decrypt(encryptedPublicKey, key);
    } on MacMismatchException {
      print("wrongly decrypted");
    }
    try {
      privateKeyPem = await _cryptor.decrypt(encryptedPrivateKey, key);
    } on MacMismatchException {
      print("wrongly decrypted");
    }

    final publicKey = _rsaHelper.parsePublicKeyFromPem(publicKeyPem);
    final privateKey = _rsaHelper.parsePrivateKeyFromPem(privateKeyPem);

    final keyPair = AsymmetricKeyPair(publicKey, privateKey);

    return keyPair;
  }

  Future<void> clearKeys() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_encryptedPublicKeyPrefsKey, null);
    prefs.setString(_encryptedPrivateKeyPrefsKey, null);
  }
  
  Future<void> seeKeys() async {
    final prefs = await SharedPreferences.getInstance();
    final encryptedPublicKey = prefs.getString(_encryptedPublicKeyPrefsKey);
    final encryptedPrivateKey = prefs.getString(_encryptedPrivateKeyPrefsKey);
    print('enc pub:');
    print(encryptedPublicKey);
    print('enc priv:');
    print(encryptedPrivateKey);
  }

}