import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/defines.dart';
import 'package:flutter_app/core/socket_handle.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home.dart';


class payment extends StatefulWidget {

  String  order_id;
  payment({ @required this.order_id }) ;

  @override
  _paymentState createState() => _paymentState();
}

class _paymentState extends State<payment> {
  @override
  Widget build(BuildContext context) {
    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);


  return  Scaffold(appBar: AppBar(
      elevation: 0,
      title: Text('انتخاب روش پرداخت ',style: TextStyle(color: Colors.black,fontSize: 14),),backgroundColor: Colors.white,
    ), body:Center(child: SingleChildScrollView(child:
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment:MainAxisAlignment.center,children: [
    InkWell(onTap : (){

    },child:     Container(height: 150,child:Column(children: [
      CachedNetworkImage(imageUrl: 'https://way2pay.ir/wp-content/uploads/Zarin-Pal-Startup-way2pay-810x322.png',
        height: 80,),
      Text('1- پرداخت آنلاین')
    ],) ,),) ,
    Divider(height: 20,color: Colors.transparent,),
    InkWell(onTap : (){
      _launchURL() async {
        String url = defines().request_payment+'?order_id='+widget.order_id;
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
        _launchURL();
      }
    },child:     Container(height: 150,child:Column(children: [
      CachedNetworkImage(imageUrl: 'https://static.cdn.asset.aparat.com/avt/6507578-6594-b.jpg',
        height: 80,),
      Text('2- ارسال تصویر چک')
    ],) ,),) ,
    Divider(height: 20,color: Colors.transparent,),
    InkWell(onTap : (){
      _launchURL() async {
        String url = defines().request_payment+'?order_id='+widget.order_id;
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
        _launchURL();
      }
    },child:     Container(height: 150,child:Column(children: [
      CachedNetworkImage(imageUrl: 'https://khorkala.com/img/cms/zarestan_cod_2.png',
        height: 80,),
      Text('3- پرداخت در محل')
    ],) ,),)

    ,
  ],)
    ,) ,) ,
    );
  }
}
