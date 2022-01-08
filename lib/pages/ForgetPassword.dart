import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/defines.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

import 'HomePage.dart';
class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {



  bool inprogress=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  Column(
        children: [

          Container(
            height: 75,
            alignment: Alignment.topCenter,
            width: double.infinity,
            child:
            Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
Container(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        'englishturbo.com',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],),

                ],
              ),


            ],),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
       Expanded(child: Stack(children: [

         Scaffold(body:  WebView(
           initialUrl: "https://englishturbo.com/",
           javascriptMode: JavascriptMode.unrestricted,
           onWebViewCreated: (WebViewController cont) {
             print('webview was created.');
           },
           onPageFinished: (String url) {
             print('url changed : ' + url);
             setState(() {
               inprogress=false;
             });

           },
         )),
         inprogress? Scaffold(body: Center(child:
         Container(height: 20,width: 20,child: CircularProgressIndicator(color: Colors.blue,) ,),)
           ,):Container(),
       ],) )

        ],
      ),

    );
  }
}
