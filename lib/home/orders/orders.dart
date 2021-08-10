import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/home/orders/order_one_item.dart';
import 'package:flutter_app/core/socket_handle.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../home.dart';
import 'order_one_level3.dart';


class orders extends StatefulWidget {

  socket_handle  connect_to_backend;
  orders({ @required this.connect_to_backend }) ;

  @override
  _ordersState createState() => _ordersState();
}

class _ordersState extends State<orders> {

  @override
  void initState() {
    getcart();
    super.initState();
  }

  void getcart() async{
    await widget.connect_to_backend.get_orders_list().then((value) => (){
      print('adada');

    });
    await   setState(() {

    });

  }
  @override
  Widget build(BuildContext context) {
    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);


    return  Scaffold(appBar: AppBar(  elevation: 0,title: Text('سفارش ها',style: TextStyle(color: Colors.black,fontSize: 14),),backgroundColor: Colors.white,
    ), body: widget.connect_to_backend.orders_list==null?
  Center(child: CircularProgressIndicator(backgroundColor: Colors.black,),)  :
    widget.connect_to_backend.orders_list.length<1?
        Container():

    ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: widget.connect_to_backend.orders_list.length,shrinkWrap: true,
        itemBuilder: (context, index) {
          return   order_one_item(connect_to_backend:  widget.connect_to_backend
            ,item: widget.connect_to_backend.orders_list[index],);
        }),
    );
  }
}
