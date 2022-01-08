import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/defines.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatePage extends StatefulWidget {
  var app_info;
    UpdatePage({key,@required this.app_info}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  @override
  void initState() {
    super.initState();
  }


  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
           Container(padding: EdgeInsets.all(50),
             child:
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text('جهت استفاده بهتر از اپلیکیشن و کارایی بیشتر آن را آپدیت کنید',textAlign: TextAlign.center,)
             ],
           )
             ,)
           ,
         Expanded(child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
           Container( child:  InkWell(onTap: (){
             _launchURL( widget.app_info['website'].toString());

           },child: Card(elevation: 5 ,color: Colors.grey[300],
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10),
             ),
             child:
             Container(
               margin: EdgeInsets.only(right: 20,left: 20,top: 5,bottom: 5 ),
               child: Text('دانلود نسخه جدید',
                   style: TextStyle(
                       fontWeight: FontWeight.bold,color: Colors.grey[800],
                       fontSize: 15)),
             ),
           )),)
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
