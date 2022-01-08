import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/database_helper.dart';
import 'package:flutter_app/defines.dart';
import 'package:flutter_app/pages/HomePage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path/path.dart' as gg;
import 'login_page.dart';

class splash extends StatefulWidget {
  const splash({key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {

  @override
  void initState() {
    super.initState();
    _navigatethome();
  }

  _navigatethome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var active = null;
    active = await prefs.getString('token');
     print('tokenNN: '+active.toString());
     if(active==null){

       Directory documentsDirectory = await getApplicationDocumentsDirectory();
       String path =await gg.join(documentsDirectory.path, DatabaseHelper.databaseName);
       try{
         await File(path).delete()
             .then((value) async{

         });
       }catch(e){}
     }
    await Future.delayed(Duration(milliseconds: 3000), () {

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>
        active != null ?
      homepage(islogin: true,)
            : homepage(islogin: false,)
      ));
    });
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) =>   homepage()  ));
    // print('splash run');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin:  Alignment(1.0, 2.0),
              end:Alignment(-1.0, -2.0),
              colors: [Colors.white, Colors.grey[200]],
              stops: [0.1, 1]),
        ),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: Container() ),
            Container(
              width: 200,
              height: 200,
              child: ClipRRect(
                child: Image.asset('assets/asatir.png'),
                borderRadius: BorderRadius.circular(300),
              ),
            )
           ,
         Expanded(child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Image.asset('images/minilogo.png',height: 20,),
               Text(' '),
               ColorizeAnimatedTextKit(
                 isRepeatingAnimation: true,pause: Duration(seconds: 0),
                 repeatForever: true,
                 onTap: () {
                   print("Tap Event");
                 },
                 text: [
                   'EnglishTurbo',
                 ],
                 textStyle:  TextStyle(
                   fontSize: 16,
                   color: Colors.white,fontStyle: FontStyle.italic,
                   fontWeight: FontWeight.bold,
                 ),
                 colors: [
                   Colors.purple[200],
                   Colors.blue[200],
                   Colors.yellow[200],
                   Colors.red[200],
                 ],
               ),
             ],)
         ],)  ),
            Expanded(child: Container()),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
             Text('V'+defines().version)
           ],),
            Container(height: 20,)
        ],),
      ),

    );
  }
}
