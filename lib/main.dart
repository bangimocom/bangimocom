
import 'dart:async';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/splashscreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:najvaflutter/najvaflutter.dart';

var najva;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  najva = NajvaFlutter();
  najva.setFirebaseEnabled(false); // set true if your app using firebase beside najva.
  najva.init('aa713545-5eec-411d-9aee-ea63e1b3545d',  33277 );

  runApp(MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // supportedLocales: [
      //   Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      // ],
      theme: ThemeData(fontFamily: 'meysam'   ,
      primarySwatch: Colors.blue,accentColor: Colors.lightBlueAccent,primaryColor: Colors.lightBlueAccent
  ),
      // locale: Locale("fa", "IR"),
      home:
      // decript_file_on_cach()
      // hyperText()
      splash()

  ));

}

