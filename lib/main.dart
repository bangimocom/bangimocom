
import 'dart:async';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splash_home.dart';
import 'splash_login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var active=null;
    active = await prefs.getString('token');

  runApp(MaterialApp(

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],  theme: ThemeData(fontFamily: 'meysam'   ,
      primarySwatch: Colors.blue,accentColor: Colors.lightBlueAccent,primaryColor: Colors.lightBlueAccent
  ),
      locale: Locale("fa", "IR"),
      home:  active != null ? splash_home() : splash_login()));

}

