import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'home/home.dart';

class splash_home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new splash_home_page();
  }

}

class splash_home_page extends State<splash_home> {

  @override
  Widget build(BuildContext context) {



    return Scaffold( 
      body: Container(
        child: Center(child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/logo.png",height: 200,width: 200,)
          ],
        )  ,)
      ),
    );
  }

  @override
  void dispose() {
super.dispose();
  }
void pre_start() async{

 await  Future.delayed( Duration(milliseconds: 3000), () {
    setState(() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (contextme) => MaterialApp(

          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],  theme: ThemeData(fontFamily: 'meysam',
            primarySwatch: Colors.blue,accentColor: Colors.lightBlueAccent,primaryColor: Colors.lightBlueAccent
        ),
          supportedLocales: [
            Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
          ],
          locale: Locale("fa", "IR"),
          home: home(),)),
            (Route<dynamic> route) => false,
      );
    });
  });
}

  @override
  void initState() {
 pre_start();
  }
}
