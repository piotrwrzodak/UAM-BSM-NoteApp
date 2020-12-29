import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pointycastle/api.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

class BioRepo {

  final _rsaHelper = RsaKeyHelper();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  static const _privKey = "storage-priv-key";
  static const _pubKey = "storage-pub-key";
  static const _note = "storage-note";

  Future<AsymmetricKeyPair> generateKeys() {
    return _rsaHelper.computeRSAKeyPair(_rsaHelper.getSecureRandom());
  }

  Future<void> storeKeys(AsymmetricKeyPair keyPair) async {
    final publicKeyPem = _rsaHelper.encodePublicKeyToPemPKCS1(keyPair.publicKey);
    final privateKeyPem = _rsaHelper.encodePrivateKeyToPemPKCS1(keyPair.privateKey);

    await secureStorage.write(key: _privKey, value: privateKeyPem);
    await secureStorage.write(key: _pubKey, value: publicKeyPem);
  }

  Future<AsymmetricKeyPair> retrieveKeys() async {
    final publicKeyPem = await secureStorage.read(key: _pubKey);
    final privateKeyPem = await secureStorage.read(key: _privKey);

    final publicKey = _rsaHelper.parsePublicKeyFromPem(publicKeyPem);
    final privateKey = _rsaHelper.parsePrivateKeyFromPem(privateKeyPem);

    final keyPair = AsymmetricKeyPair(publicKey, privateKey);

    return keyPair;
  }

  Future<AsymmetricKeyPair> getKeys() async {
    var containsEncryptionKey = await secureStorage.containsKey(key: _pubKey);
    if (!containsEncryptionKey)  {
      final newKeys = await generateKeys();
      await storeKeys(newKeys);
    }
    final keys = await retrieveKeys();

    return keys;
  }

  Future<void> encryptNote(String text) async {
    final keys = await getKeys();
    final encrypter = Encrypter(RSA(publicKey: keys.publicKey, privateKey: keys.privateKey));
    final encrypted = encrypter.encrypt(text);
    final encryptedNoteToStorage = encrypted.base64;
    await secureStorage.write(key: _note, value: encryptedNoteToStorage);
  }

  Future<String> decryptNote() async {
    final keys = await getKeys();
    final encrypter = Encrypter(RSA(publicKey: keys.publicKey, privateKey: keys.privateKey));

    final encryptedText = await secureStorage.read(key: _note);
    
    if (encryptedText != null) {
      Encrypted toDecrypt = Encrypted.fromBase64(encryptedText);
      final decrypted = encrypter.decrypt(toDecrypt);
      return decrypted;
    }
    else {
      return "Here save your note!";
    }
  }

  Future<void> clear() async {
    await secureStorage.deleteAll();
  }
}