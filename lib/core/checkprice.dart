import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/socket_handle.dart';

class checkprice {
  socket_handle  connect_to_backend;
  String  price1;
  String  price2;
  checkprice({@required this.connect_to_backend,@required this.price1,@required this.price2,});
 String check(){
 return  (connect_to_backend.level=='1'?  price1:  price2);
 }
}