import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';

import 'package:encrypt/encrypt.dart'  as en;
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

class decript_file3 extends StatefulWidget {
  const decript_file3({key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<decript_file3> {



  @override
  void initState() {
   // encryptFile(  ) ;
    decryptFile();
    super.initState();
  }


  final key = en.Key.fromUtf8('pT8ZDjwCvnWkfPEYBm12q2p9srNkM-nW');
  IV iv = IV.fromLength(16);

  encryptFile() async {

    Directory   fith=await getExternalStorageDirectory();
    String   filePath=await fith.path  +'/a.mp4';
    File inFile = await File(filePath);
    File outFile = await File(filePath+".aes");

    bool outFileExists = await outFile.exists();

    if(!outFileExists){
      await outFile.create();
    }

    final videoFileContents = await inFile.readAsStringSync(encoding: latin1);


    final encrypter =await Encrypter(AES(key,mode: AESMode.cbc));

    final encrypted =await encrypter.encrypt(videoFileContents, iv: iv);
    await outFile.writeAsBytes(encrypted.bytes);
  }

 Future<bool> decryptFile() async {
    Directory   fith=await getExternalStorageDirectory();
    String   filePath=await fith.path  +'/a.mp4.enc';
    print('iv:'+iv.toString());
    File inFile = await File(filePath);
    File outFile = await File(filePath+".mp4");

    bool outFileExists = await outFile.exists();

    if(!outFileExists){
      await outFile.create();
    }

    final videoFileContents = await inFile.readAsBytesSync();


    final encrypter =await Encrypter(AES(key,mode: AESMode.cbc));

    final encryptedFile =await Encrypted(videoFileContents);
    final decrypted =await encrypter.decrypt(encryptedFile, iv: iv);

    final decryptedBytes =await latin1.encode(decrypted);
 File  ss=   await  outFile.writeAsBytes(decryptedBytes);
 return  await  ss.exists();
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}
