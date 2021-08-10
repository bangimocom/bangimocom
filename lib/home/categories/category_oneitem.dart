
import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/defines.dart';
import 'package:flutter_app/home/categories/category_products/category_products.dart';
import 'package:flutter_app/home/product_list.dart';
import 'package:flutter_app/core/socket_handle.dart';
import 'package:provider/provider.dart';
import 'package:ripple_effect/ripple_effect.dart';



class category_oneitem extends StatefulWidget {
  socket_handle  connect_to_backend;
  var item;
  category_oneitem({Key key, this.title,@required this.connect_to_backend ,@required this.item }) : super(key: key);

  final String title;

  @override
  _category_oneitemState createState() =>  _category_oneitemState();
}

class _category_oneitemState extends State<category_oneitem> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return  Container(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 10,
        child:InkWell(onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  category_products(connect_to_backend: widget.connect_to_backend,
              category: widget.item['_id'].toString(),category_name: widget.item['name'].toString(),)));


        },child:  Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(child:Row(children: [
              Expanded(child:CachedNetworkImage(
                imageUrl: defines().image_folder+widget.item['picture'].toString(),
                fit: BoxFit.fill,) ,)
            ],)  ,),Divider(height: 10,color: Colors.transparent,)
            ,Text(widget.item['name'].toString(),style: TextStyle(fontSize: 12),),
            Divider(height: 5,color: Colors.transparent,)
          ],
        ),),
      ),
    ) ;
  }
}



