import 'package:encrypt/encrypt.dart';

class MyEnctyptionDecryption {
  // for AES Encrytion / Decryption

  // static final key = encrypt.Key.fromLength(32);
  // static final iv = encrypt.IV.fromLength(16);
  // static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  // static encryptAES(text){

  //   final encrypted = encrypter.encrypt(text, iv: iv);

  //   print(encrypted.bytes);
  //   print(encrypted.base16);
  //   print(encrypted.base64);
  //   return encrypted;

  // }

  // static decryptAES(text){
  //   final decrypted = encrypter.decrypt(text, iv: iv);
  //   print(decrypted);
  //   return decrypted;

  // }
    static final key = Key.fromLength(32); 
    static final iv = IV.fromLength(16);

  // Flutter Encryption
  static encrypt(String text) {

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(text, iv: iv);
    print('Text : $text');
    print('encrypted : ${encrypted.base64}');

    return encrypted.base64;
  }

// Flutter Decryption
 static decrypt(String text){
   final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
   final decryted = encrypter.decrypt(Encrypted.fromBase64(text), iv: iv);

   print('Text : $text');
    print('decrypted : $decrypt');

   return decryted;
 }
}
