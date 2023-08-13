import 'dart:developer';
import 'package:encrypt/encrypt.dart';
import '../../../Constants/constant.dart';

///encrypt the url
String decryptUrl(String url) {
  try {
    log('-------------------------------- Encrypted  : ' + url);

    final key = Key.fromUtf8(ENC_KEY);
    final iv = IV.fromLength(16);

    final encryptor = Encrypter(AES(key));

    final decrypted = encryptor.decrypt64(url, iv: iv);

    log('-------------------------------- Decrypted  : ' + decrypted);

    return decrypted;
  } catch (e) {
    log(e.toString());
  }

  return "";
}
