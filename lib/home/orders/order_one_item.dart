import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/socket_handle.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../home.dart';
import 'order_one_level3.dart';


class order_one_item extends StatefulWidget {

  socket_handle  connect_to_backend;
  var  item;
  order_one_item({ @required this.connect_to_backend,@required this.item  }) ;

  @override
  _order_one_itemState createState() => _order_one_itemState();
}

class _order_one_itemState extends State<order_one_item> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);


    return  InkWell(
      onTap: (){
        Navigator
            .of(context)
            .push(MaterialPageRoute(builder: (_) => order_one_level3(connect_to_backend: connect_to_backend,
          order_id: widget.item['_id'].toString(),
          order_level:  widget.item['level'].toString(),
          order_address:  widget.item['address'].toString(),
          order_mobile: widget.item['mobile'].toString(),)));

      },
      child: Card(
        margin: EdgeInsets.all(5),shape: StadiumBorder(),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: <Widget>[
                Text('سفارش '+widget.item['_id'].toString()
                  ,style: TextStyle(color: Colors.black,fontSize: 14),overflow: TextOverflow.ellipsis,),
                Text(widget.item['level']==1?' در انتظار تایید ویزیتور':
                widget.item['level']==2?' در انتظار تایید ادمین':
                widget.item['level']==3?' تایید نشده توسط ادمین':
                widget.item['level']==4?' در انتظار پرداخت':
                widget.item['level']==5?' در انتظار تایید چک':
                widget.item['level']==6?' چک تایید شده':
                widget.item['level']==7?' پرداخت در محل':
                widget.item['level']==8?' پرداخت شده آنلاین':' پست شده '
                    ,style: TextStyle(color: Colors.black,fontSize: 14)),
              ],
            ),Text('  '),CachedNetworkImage(height: 30,
              imageUrl: 'https://www.clipartmax.com/png/middle/215-2155928_mobile-ordering-apps-order-png.png',)
          ],),),);
  }
}
