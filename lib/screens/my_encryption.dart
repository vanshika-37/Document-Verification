import 'package:encrypt/encrypt.dart' as encrypt;

class MyEncryptionDecryption {
  //For AES Encryption/Decryption
  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  static encryptAES(text) {
    final encrypted = encrypter.encrypt(text, iv: iv);

    print(encrypted.bytes);
    print(encrypted.base16);
    print(encrypted.base64);
    return encrypted;
  }

  static decryptAES(text) {
    final decrypted = encrypter.decrypt(text, iv: iv);
    print(decrypted);
    return decrypted;
  }

  // For Fernet Encryption/Decryption
 
 

  // For Salsa20 Encryption/Decryption
  static final keySalsa20 = encrypt.Key.fromLength(32);
  static final ivSalsa20 = encrypt.IV.fromLength(8);
  static final encrypteSalsa20 = encrypt.Encrypter(encrypt.Salsa20(keySalsa20));

  static encryptSalsa20(text) {
    final encrypted = encrypteSalsa20.encrypt(text, iv: ivSalsa20);
    // print(encrypted.bytes);
    // print(encrypted.base16);
    // print(encrypted.base64);
    return encrypted;
  }

  static decryptSalsa20(text) {
    return encrypteSalsa20.decrypt(text, iv: ivSalsa20);
  }
}
