import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:encrypt/encrypt.dart' as en;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
//php :
// <?php
//
// const key = 'MySecretKeyForEncryptionAndDecry'; // 32 chars
// const iv = 'helloworldhellow'; // 16 chars
// const method = 'aes-256-cbc';
//
// function encryp($text){
//   //   $text should be String
//   return openssl_encrypt($text, method, key, 0, iv);
// }
// echo encryp('f');


class decript extends StatefulWidget {
  const decript({key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<decript> {

  @override
  void initState() {
   print( decryp('EZLjYCrTwGB9KJctVb5bAg==' ));
    super.initState();
  }


  final key = en.Key.fromUtf8('MySecretKeyForEncryptionAndDecry'); //32 chars
  final iv = en.IV.fromUtf8('helloworldhellow'); //16 chars

  String decryp(String text) {
    final encrypter = en.Encrypter(en.AES(key, mode: en.AESMode.cbc));
    final decrypted = encrypter.decrypt(en.Encrypted.fromBase64(text), iv: iv);
    return decrypted;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}
