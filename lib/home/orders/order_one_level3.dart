import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/defines.dart';
import 'package:flutter_app/home/cart/cart.dart';
import 'package:flutter_app/home/orders/order_one_level3_one_item.dart';
import 'package:flutter_app/home/orders/payment.dart';
import 'package:flutter_app/core/socket_handle.dart';
import 'package:provider/provider.dart';



class order_one_level3 extends StatefulWidget {

  socket_handle  connect_to_backend;
  String  order_id;
  String  order_level;
  String  order_address;
  String  order_mobile;
  order_one_level3({ @required this.connect_to_backend
    , @required this.order_id
    , @required this.order_level , @required this.order_address, @required this.order_mobile }) ;

  @override
  _order_one_level3State createState() => _order_one_level3State();
}

class _order_one_level3State extends State<order_one_level3> {
  @override
  void initState() {

    getcart();
    print(widget.connect_to_backend.home_list[1]['address'].toString());
    super.initState();
  }

  void getcart() async{
    await widget.connect_to_backend.get_orders_one_user(widget.order_id).then((value) => (){
      // print( widget.connect_to_backend.orders_one_userlist.length.toString());

    });
    await   setState(() {

    });

  }
  @override
  Widget build(BuildContext context) {
    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);

  return  Scaffold(appBar: AppBar(
      elevation: 0,
      title: Text('سفارش ',style: TextStyle(color: Colors.black,fontSize: 14),),backgroundColor: Colors.white,
    ), body: widget.connect_to_backend.orders_one_userlist==null
        ? Center(child: CircularProgressIndicator(),):
    widget.connect_to_backend.orders_one_userlist.length<1?
    Container():
Column(children: [
  Divider(height: 10,color: Colors.transparent,),
  Text('آدرس : ' + (widget.order_address==''?
(connect_to_backend.home_list[1]['address'].toString()):widget.order_address)
 ,style: TextStyle(color: Colors.green[800]), ),

  Divider(height: 10,color: Colors.transparent,),
  ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: widget.connect_to_backend.orders_one_userlist.length,shrinkWrap: true,
      itemBuilder: (context, index) {
        return
          order_one_level3_one_item(item: widget.connect_to_backend.orders_one_userlist[index]);
      }),
],),




        bottomNavigationBar:widget.order_level=='4'? InkWell(
          onTap: (){
            Navigator
                .of(context)
                .push(MaterialPageRoute(builder: (_) => payment(order_id: widget.order_id, )));
          },
          child:Container(
            height: 40,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue[100], Colors.blue[300]],
                    begin:   FractionalOffset(0.0, 0.0),
                    end:   FractionalOffset(0.5, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                ),borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
            ),child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('پرداخت',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                  fontSize: 14),)
            ],),) ,) :
        widget.order_level=='1'? Container(
          height: 40,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.pink[100], Colors.pink[300]],
                  begin:   FractionalOffset(0.0, 0.0),
                  end:   FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp
              ),borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
          ),child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            connect_to_backend.home_list[1]['role'].toString()!='visitor'?  Text('در انتظار تایید ویزیتور',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                fontSize: 14),): Row(children: [
            InkWell(onTap: (){

              connect_to_backend.change_level('2', widget.order_id, context);

              },child:
        Container(
          width: 100,color: Colors.brown[800],
          child:  Text(' تایید ',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
            fontSize: 14),),)  ,),
            InkWell(onTap: (){
              for(var i=0;i<connect_to_backend.options.length;i++){
                if(connect_to_backend.options[i].value==widget.order_mobile){
                  connect_to_backend.title= connect_to_backend.options[i].title;
                  connect_to_backend.my_phone=widget.order_mobile;
                  print(connect_to_backend.options[i].title);
                  break;
                }
              }

          connect_to_backend.change_level('0', widget.order_id, context);
            },child:
           Container(
             width: 100,color: Colors.red[800],child:  Text(' ویرایش ',textAlign: TextAlign.center,
             style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
               fontSize: 14),),),)
          ],)
          ],),) :
        widget.order_level=='2'?  Container(
          height: 40,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.yellow[100], Colors.yellow[300]],
                  begin:   FractionalOffset(0.0, 0.0),
                  end:   FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp
              ),borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
          ),child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('در انتظار تایید ادمین',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                fontSize: 14),)
          ],),) :
        widget.order_level=='3'?  Container(
          height: 40,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.red[100], Colors.red[300]],
                  begin:   FractionalOffset(0.0, 0.0),
                  end:   FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp
              ),borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
          ),child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(' با ویزیتور تماس بگیرید',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                fontSize: 14),)
          ],),) :
        widget.order_level=='5'?  Container(
          height: 40,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.teal[100], Colors.teal[300]],
                  begin:   FractionalOffset(0.0, 0.0),
                  end:   FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp
              ),borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
          ),child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('در انتظار تایید چک',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                fontSize: 14),)
          ],),) :
        widget.order_level=='6'?  Container(
          height: 40,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.purple[100], Colors.purple[300]],
                  begin:   FractionalOffset(0.0, 0.0),
                  end:   FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp
              ),borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
          ),child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('چک تایید شده',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                fontSize: 14),)
          ],),) :
        widget.order_level=='7'?  Container(
          height: 40,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.brown[100], Colors.brown[300]],
                  begin:   FractionalOffset(0.0, 0.0),
                  end:   FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp
              ),borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
          ),child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('پرداخت در محل',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                fontSize: 14),)
          ],),):
        widget.order_level=='8'?  Container(
          height: 40,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.orange[100], Colors.orange[300]],
                  begin:   FractionalOffset(0.0, 0.0),
                  end:   FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp
              ),borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
          ),child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('پرداخت شده آنلاین',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                fontSize: 14),)
          ],),) :
        Container(
          height: 40,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.green[100], Colors.green[300]],
                  begin:   FractionalOffset(0.0, 0.0),
                  end:   FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp
              ),borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
          ),child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('پست شده',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                fontSize: 14),)
          ],),)
    );
  }
}
