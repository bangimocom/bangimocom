import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
// <?php
//
// const key = 'FCAcEA0HBAoRGyALBQIeCAcaDxYWEQQPBxcXHgAFDgY='; // 32 chars
// const iv = 'DB4gHxkcBQkKCxoRGBkaFA=='; // 16 chars
//
// function encryptFile($encKey, $encIV, $inPath, $outPath) {
//   $text=file_get_contents($inPath);
//   $key = base64_decode($encKey);
//   $iv = base64_decode($encIV);
//   $encrypter = 'aes-256-cbc';
//   $encrypted = openssl_encrypt($text, $encrypter, $key, 0, $iv);
//   if(file_put_contents($outPath,$encrypted)!= false) return 1;
//   else return 0;
// }
// echo encryptFile(key,iv,'videos/testfile.txt','videos/testfile.txt'.'.enc');

class decript_file extends StatefulWidget {
  const decript_file({key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<decript_file> {



  @override
  void initState() {
   decryptFile(  ) ;
    super.initState();
  }


  Future<String> decryptFile() async{
    //'filePath' contains the php encrypted video file.
 Directory   fith=await getExternalStorageDirectory();
 String   filePath=fith.path+ '/testfile.txt.enc';
 var encodedKey = 'FCAcEA0HBAoRGyALBQIeCAcaDxYWEQQPBxcXHgAFDgY=';
    var encodedIv = 'DB4gHxkcBQkKCxoRGBkaFA==';
    var text = new File(filePath).readAsStringSync();
    final key1 = enc.Key.fromBase64(encodedKey);
    final iv = enc.IV.fromBase64(encodedIv);
    final encrypter = enc.Encrypter(enc.AES(key1, mode: enc.AESMode.cbc));
    final decrypted = encrypter.decrypt(enc.Encrypted.fromBase64(text), iv: iv);

    List<int> bytes = utf8.encode(decrypted);print(bytes);
    var newFile = new File(filePath+'.mp4');
    await newFile.writeAsBytes(bytes);
    return filePath;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}
