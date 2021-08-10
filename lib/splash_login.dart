
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

import 'login/login.dart';
class splash_login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new splash_login_page();
  }

}

class splash_login_page extends State<splash_login> {
  final pages = [
    PageViewModel(
        pageColor: Colors.white,
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/logo.png'),
        body: Text(
          'خوش آمدید',style: TextStyle(color: Colors.black,fontSize: 12),
        ),
        title: Text(
          'گالری پروانه',style: TextStyle(color: Colors.black,fontSize: 12),
        ),
        titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        mainImage: Image.asset(
          'assets/logo.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
        pageColor: Colors.blue[200],
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/logo.png'),
        body: Text(
          'به راحتی سفارش دهید',style: TextStyle(color: Colors.white,fontSize: 12),
        ),
        title: Text(
          'گالری پروانه',style: TextStyle(color: Colors.white,fontSize: 12),
        ),
        titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        mainImage: Image.asset(
          'assets/slider1.png',
          height: 285.0,color: Colors.white,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
        pageColor: Colors.blue[400],
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/logo.png'),
        body: Text(
          'از جدیدترین تخفیف ها و پیام ها باخبر شوید',style: TextStyle(color: Colors.white,fontSize: 12),
        ),
        title: Text(
          'گالری پروانه',style: TextStyle(color: Colors.white,fontSize: 12),
        ),
        titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        mainImage: Image.asset(
          'assets/slider2.png',
          height: 285.0,color: Colors.white,
          width: 285.0,
          alignment: Alignment.center,
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IntroViews Flutter', //title of app
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), //ThemeData
      home: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          showNextButton: true,
          showBackButton: true,
          doneText: Text('بستن' )
          ,nextText:Text('بعدی' ) ,
          backText: Text('قبلی' ),
          skipText: Text('بستن' ),
          onTapDoneButton: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (contextme) => login()),
                  (Route<dynamic> route) => false,
            );
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.black,
            fontSize: 20.0,fontWeight: FontWeight.bold
          ),
        ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}

