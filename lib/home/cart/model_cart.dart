import 'package:flutter/material.dart';

class model_cart {
  String  item_id;
  String product_id;
  int number;
  String order_id;
  String price;
  String name;
  String category;
  String post_price;
  String description;
  List  items;
  String dsc;
  String timeStamp;

  model_cart({@required this.item_id,@required this.product_id, @required this.number, @required this.order_id
    , @required this.price, @required this.name, @required this.category, @required this.post_price
    , @required this.description, @required this.items, @required this.dsc, @required this.timeStamp});
}