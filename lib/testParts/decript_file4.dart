import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_zip_archive/flutter_zip_archive.dart';

import 'package:path_provider/path_provider.dart';
//php :
// <?php
// $zip = new ZipArchive();
// if ($zip->open('test.zip', ZipArchive::CREATE) === TRUE) {
// $zip->setPassword('1234'); //set default password
//
// $zip->addFile('a.mp4'); //add file
// $zip->setEncryptionName('a.mp4', ZipArchive::EM_AES_256); //encrypt it
//
//
// $zip->close();
//
// echo "Added thing1 and thing2 with the same password\n";
// } else {
// echo "KO\n";
// }
// ?>


class decript_file4 extends StatefulWidget {
  const decript_file4({key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<decript_file4> {

  @override
  void initState() {
   print(decryp( 'EZLjYCrTwGB9KJctVb5bAg==' ))  ;
    super.initState();
  }


  Future<String> decryp(String text) async{
    Directory   fith=await getExternalStorageDirectory();
    String   filePath=await fith.path  +'/a.zip';
    // Directory _cacheDir = await getTemporaryDirectory();
    var _map=await FlutterZipArchive.unzip(filePath,filePath+'.mp4',"1234");
    print("_map:"+_map.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}
