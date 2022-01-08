import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:aes_crypt/aes_crypt.dart';
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

class decript_file2 extends StatefulWidget {
  const decript_file2({key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<decript_file2> {

  var crypt;

  @override
  void initState() {


    decryptFile(  ) ;
    super.initState();
  }


  String decFilepath;
  Future<String> decryptFile() async {
    crypt = await  AesCrypt();
    await  crypt.setPassword('c2Rmc2Rmc2QzNDNyZXRyZXRyZXRlcnQ=');
    await  crypt.setOverwriteMode(AesCryptOwMode.warn);
    //'filePath' contains the php encrypted video file.
    Directory fith = await getExternalStorageDirectory();
    String filePath =await  fith.path + '/2.mp4';
    try {
      // Decrypts the file which has been just encrypted.
      // It returns a path to decrypted file.
      decFilepath =await  crypt.decryptFileSync(filePath , './a.mp4');
      print('The decryption has been completed successfully.');
      print('Decrypted file 1: $decFilepath');
    } on AesCryptException catch (e) {
      // It goes here if the file naming mode set as AesCryptFnMode.warn
      // and decrypted file already exists.
      if (e.type == AesCryptExceptionType.destFileExists) {
        print('The decryption has been completed unsuccessfully.');
        print(e.message);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}
