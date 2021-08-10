import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/defines.dart';
import 'file:///C:/my_project_important/parvaneh_gallery/flutter_mobile/lib/core/checkprice.dart';
import 'package:flutter_app/home/orders/payment.dart';
import 'package:flutter_app/core/socket_handle.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../home.dart';

import  'package:persian_number_utility/persian_number_utility.dart';

class order_one_level3_one_item extends StatefulWidget {

  var  item;
  order_one_level3_one_item({ @required this.item }) ;

  @override
  _order_one_level3_one_itemState createState() => _order_one_level3_one_itemState();
}

class _order_one_level3_one_itemState extends State<order_one_level3_one_item> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);

    List data=json.decode( widget.item);
    String price= checkprice(connect_to_backend: connect_to_backend ,
        price1: data[1]['price1'].toString()
        , price2: data[1]['price2'].toString()).check();
    int totalprice=int.parse(  price.replaceAll(',', ''));
    int number=int.parse( data[0]['number'].toString() );
    List pics=data[1]['items'];
    return  Card(
      margin: EdgeInsets.all(5),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          CachedNetworkImage(fit: BoxFit.fill,height: 130,width: 100,

              imageUrl:
              pics.length<2?'http://www.actbus.net/fleetwiki/images/8/84/Noimage.jpg':
              defines().image_folder+
                  (pics[0].toString().contains('.')?pics[0].toString(): pics[1].toString())),
          Text('  '),  Expanded(child: Column(
            children: <Widget>[
              Text(data[1]['name'].toString(),style: TextStyle(color: Colors.black,fontSize: 14),overflow: TextOverflow.clip,),
              Text(' تعداد '+number.toString()+' تا',style: TextStyle(color: Colors.black,fontSize: 14)),
              Text('قیمت واحد '+price,style: TextStyle(color: Colors.black,fontSize: 14)),
              Text('قیمت کل '+(totalprice*number).toString().seRagham(separator: ","),style: TextStyle(color: Colors.black,fontSize: 14)),
            ],
          ) ,)
        ],),);
  }
}
