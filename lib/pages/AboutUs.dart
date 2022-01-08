import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/socket_handle.dart';


import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
class AboutUs extends StatefulWidget {
  socket_handle connect_to_backend;
  AboutUs({@required this.connect_to_backend});
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {


  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return    widget.connect_to_backend.aboutus==null?Center(child: Container(width: 20,height: 20,child:
    CircularProgressIndicator(color: Colors.blue,),),):
   Column(children: [

      Container(
        height: 75,
        alignment: Alignment.topCenter,
        width: double.infinity,
        child:
        Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(height: 20,color: Colors.transparent,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    'about us',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],)],
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
      Expanded(child: SingleChildScrollView(child:  Column(
        children: [
          Divider(
            height: 20,
            color: Colors.transparent,
          ),

          Divider(
            height: 20,
            color: Colors.transparent,
          ),
          Container(
            margin: EdgeInsets.only(right: 10,left: 10 , ),
            child:InkWell(onTap: (){
              _launchURL( widget.connect_to_backend.aboutus['instagram'].toString());

            },child: Card(elevation: 5,color: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Text('   instagram',
                                style: TextStyle(color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            padding: EdgeInsets.all(8),
                            child: Image.asset(
                              'assets/instagram.png',width: 30,height: 30,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),) ,
          ),
          Container(
            margin: EdgeInsets.only(right: 10,left: 10 , ),
            child: InkWell(onTap: (){
              _launchURL( widget.connect_to_backend.aboutus['website'].toString());

            },child: Card(elevation: 5 ,color: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Text('   website',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,color: Colors.grey[800],
                                    fontSize: 15)),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            padding: EdgeInsets.all(8),
                            child: Image.asset(
                              'assets/website.png',width: 30,height: 30,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            )),
          ),
          Container(
            margin: EdgeInsets.only(right: 10,left: 10 , ),
            child:InkWell(onTap: (){
              _launchURL( widget.connect_to_backend.aboutus['telegram'].toString());

            },child: Card(elevation: 5,color: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Text('   telegram',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,color: Colors.grey[800],
                                    fontSize: 15)),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            padding: EdgeInsets.all(8),
                            child: Image.asset(
                              'assets/telegram.png',width: 30,height: 30,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ) ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10,left: 10 , ),
            child:InkWell(onTap: (){

            },child: Card(elevation: 5,color: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Text('   version : '+ widget.connect_to_backend.aboutus['version'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,color: Colors.grey[800],
                                    fontSize: 15)),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            padding: EdgeInsets.all(8),
                            child: Image.asset(
                              'assets/logo.png',width: 30,height: 30,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ) ),
          ),
          Divider(
            height: 20,
            color: Colors.transparent,
          ),
          Container(
            margin: EdgeInsets.only(right: 10,left: 10 , ),
            child: Card(elevation: 5,color: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Html(
                        data: widget.connect_to_backend.aboutus['description'].toString() ,customTextAlign: (_) => TextAlign.left,)

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )  ,))

    ],) ;
  }
}
