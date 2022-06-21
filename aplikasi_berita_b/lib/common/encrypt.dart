import 'package:encrypt/encrypt.dart';

String encrypt(String plainText) {
  final key = Key.fromUtf8('3983f8b3ef464319b07dc87586d4de20');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final Encrypted = encrypter.encrypt(plainText, iv: iv);

  return Encrypted.base64;
}
