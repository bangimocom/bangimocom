import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/defines.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class Back__Button extends StatefulWidget {
BuildContext cc;
  Back__Button({@required this.cc});

  @override
  _Back__ButtonState createState() => _Back__ButtonState();
}

class _Back__ButtonState extends State<Back__Button> {



  bool inprogress=true;
  @override
  Widget build(BuildContext context) {
    return   InkWell(
        onTap: (){
          Navigator.pop(widget.cc);
        },
        child:Container(
          padding: EdgeInsets.all(3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('  '),
              Icon(Icons.arrow_back_ios,color: Colors.blue,)
            ],),

          decoration: BoxDecoration(borderRadius: BorderRadius.circular(200),border: Border.all(color: Colors.black87)),
        ));
  }
}
