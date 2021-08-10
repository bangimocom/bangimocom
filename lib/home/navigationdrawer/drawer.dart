import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/defines.dart';
import 'package:flutter_app/home/cart/cart.dart';
import 'package:flutter_app/home/categories/category.dart';
import 'package:flutter_app/home/edit_profile/edit_profile.dart';
import 'package:flutter_app/home/orders/orders.dart';
import 'package:flutter_app/core/socket_handle.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../home.dart';


class drawer extends StatefulWidget {


  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);


  return  SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,//20.0,
      child: Drawer(
          child:ListView(
            children: [
              Column(children: [

                Divider(height: 10,color: Colors.transparent,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                 Container(width: MediaQuery.of(context).size.width*0.4,
                   height: MediaQuery.of(context).size.width*0.4 ,

                   child: ClipRRect(child:  CachedNetworkImage(
                     imageUrl:
                     connect_to_backend.home_list[1]['picture'].toString()==""?"https://espindula.com.br/imagens/avatar.jpg":
                     defines().image_folder+ connect_to_backend.home_list[1]['picture'].toString(),
                     placeholder: (context, url) => CircularProgressIndicator(),
                     errorWidget: (context, url, error) => Image.asset('assets/avatar.png'),
                     fit: BoxFit.fill,
                     fadeInCurve: Curves.easeIn ,
                     fadeInDuration: Duration(seconds: 2),
                     fadeOutCurve: Curves.easeOut,
                     fadeOutDuration: Duration(seconds: 2),

                   ),borderRadius: BorderRadius.all(Radius.circular(400)),),)
                  ],) ,
                Divider(height: 10,color: Colors.transparent,),
                Text(connect_to_backend.home_list[1]['name'].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16),)    ,
                Divider(height: 5,color: Colors.transparent,),
                Text(connect_to_backend.home_list[1]['manager_name'].toString(),style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 12),)    ,
                Divider(height: 5,color: Colors.transparent,),
                Text(connect_to_backend.home_list[1]['mobile'].toString(),style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 12),)    ,

              ],),
              Divider(height: 30,color: Colors.transparent,),
              InkWell(
                child:Container(height: 40,child:  Row(children: [
                  Text('   '),
                  Icon(Icons.category,size: 20,color: Colors.grey[400],),Text(' '),
                  Text("دسته بندی ها",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal),)
                ],),) ,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  category(connect_to_backend: connect_to_backend,)));
                },
              ),
              InkWell(
                child:Container(height: 40,child:Row(children: [
                  Text('   '),
                  Icon(Icons.person,size: 20,color: Colors.grey[400],),Text(' '),
                  Text("پروفایل",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal),)
                ],))  ,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  edit_profile( connect_to_backend: connect_to_backend,)));
                },
              ),
              InkWell(
                child:Container(height: 40,child:Row(children: [
                  Text('   '),
                  Icon(Icons.shopping_cart,size: 20,color: Colors.grey[400],),Text(' '),
                  Text("سبد خرید",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal),)
                ],) )  ,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  cart(connect_to_backend: connect_to_backend,)));
                },
              ),
              InkWell(
                child:Container(height: 40,child:Row(children: [
                  Text('   '),
                  Icon(Icons.bookmark_border,size: 20,color: Colors.grey[400],),Text(' '),
                  Text("سفارش ها",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal),)
                ],))   ,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  orders(connect_to_backend: connect_to_backend,)));
                },
              ),
              InkWell(
                child:Container(height: 40,child:  Row(children: [
                  Text('   '),
                  Icon(Icons.close_rounded,size: 20,color: Colors.grey[400],),Text(' '),
                  Text("خروج",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal),)
                ],)) ,
                onTap: () {
                  Navigator.pop(context);
           connect_to_backend.logout();
                },
              ),
            ],
          ), ),
    );
  }
}
