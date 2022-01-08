import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';


class hyperText extends StatefulWidget {
  String mobile;
    hyperText({key,@required this.mobile}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<hyperText> {
double x=0;
double y=0;
Random rnd = new Random();
int mini = 1;
int max = 9;

double get_random(){
int  r = mini + rnd.nextInt(max - mini);
  return  r/10;
}
@override
  void dispose() {
  tt.cancel();
    super.dispose();
  }
  Timer tt;
@override
  void initState() {


  tt=    Timer.periodic(
      Duration(seconds: 1),
          (Timer timer) => setState(
            () {
x=get_random();
y=get_random();
        },
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(alignment:  Alignment(x, y) ,child:
        Text(widget.mobile,style: TextStyle(color: Colors.red,fontSize: 12),)
          ,)
      ],);
  }
}
