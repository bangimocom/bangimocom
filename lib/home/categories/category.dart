
import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/home/categories/category_oneitem.dart';
import 'package:flutter_app/home/product_list.dart';
import 'package:flutter_app/core/socket_handle.dart';
import 'package:provider/provider.dart';
import 'package:ripple_effect/ripple_effect.dart';



class category extends StatefulWidget {
  socket_handle  connect_to_backend;
  category({Key key, this.title,@required this.connect_to_backend }) : super(key: key);

  final String title;

  @override
  _categoryState createState() =>  _categoryState();
}

class _categoryState extends State<category> {

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  void initState() {
    get_cat();

    super.initState();
  }
  void get_cat() async{
    await widget.connect_to_backend.get_cat_for_user(  0, 20);
    await  setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);

    return Scaffold(backgroundColor: Colors.white ,appBar: AppBar(
      automaticallyImplyLeading: false,
      title: Row(children: [
       InkWell(child: Icon(Icons.arrow_back,color: Colors.grey),onTap: (){
Navigator.pop(context);
      },),
      Text(' '),
      Expanded(child:Text( 'دسته بندی ها',style: TextStyle(fontSize: 14),),),

    ],),backgroundColor: Colors.white,),body:

        connect_to_backend.cat_for_user_list.length<1?
        Center(child: Container(width: 30,height: 30,child:
        CircularProgressIndicator(backgroundColor: Colors.black,)
          ,),) :
        GridView.builder(
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: connect_to_backend.cat_for_user_list.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext content, int index) {
            return category_oneitem(connect_to_backend: connect_to_backend,
                item:  connect_to_backend.cat_for_user_list[index]) ;
          },
        )


      ,);
  }
}



