import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/defines.dart';
import 'file:///C:/my_project_important/parvaneh_gallery/flutter_mobile/lib/core/checkprice.dart';
import 'package:flutter_app/core/socket_handle.dart';


import '../home.dart';
import 'cart.dart';
import 'model_cart.dart';


class cart_item extends StatefulWidget {

  socket_handle  connect_to_backend;
  model_cart  item;

  cartState pre_class;
  int index;
  cart_item({ @required this.item ,@required this.connect_to_backend
    ,@required this.pre_class,@required this.index}) ;


  @override
  _cart_itemState createState() => _cart_itemState();
}

class _cart_itemState extends State<cart_item> {

  String  number='0';
  @override
  void initState() {
      number= widget.item.number.toString() ;
      setState(() {

      });

    super.initState();
  }

 bool progress=false;
  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all( 10 ),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: CachedNetworkImage(imageUrl: widget.item.items.length<2?'http://www.actbus.net/fleetwiki/images/8/84/Noimage.jpg':
              widget.item.items[0].toString().contains('.')?
              defines().image_folder+widget.item.items[0].toString():
              defines().image_folder+widget.item.items[1].toString()
                ,),
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(child:  Container(
          width: MediaQuery.of(context).size.width,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.name.toString(),
                style: TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 3,overflow: TextOverflow.clip,
              ),
              SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text:   widget.item.price.toString() +' تومان ',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black),
                  children: [
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 80,height: 35,child:  Row(
                    children: <Widget>[
                      Expanded(flex:1,child:Center(child: InkWell(onTap: (){
                        setState(() {
                          progress=true;

                        });
                        widget.connect_to_backend.add_to_cart(widget.item.product_id, 'add').then((value) {
                          setState(() {
                            number=value;
                            widget.item.number+=1;
                            progress=false;
                            widget.pre_class.set_sum() ;
                          });
                        });
                      },child: Icon(Icons.add,color: Colors.redAccent),),) ,),
                      Expanded(flex:2,child:Center(child:
                      progress?Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: 10,height: 10,child: CircularProgressIndicator(strokeWidth: 0.3,),)],):

                      Text(number,style: TextStyle(color: Colors.redAccent,fontSize: 20),),) ,),
                      number!='1'?   Expanded(flex:1,child:Center(child: InkWell(onTap: (){
                        setState(() {
                          progress=true;
                        });
                        widget.connect_to_backend.add_to_cart(widget.item.product_id, 'mines', ).then((value) {
                          setState(() {
                            number=value;
                            progress=false;
                            widget.item.number-=1;
                            widget.pre_class.set_sum() ;
                          });
                        });
                      },child: Icon(number=='1'?Icons.restore_from_trash:Icons.remove,color: Colors.redAccent),),) ,):
                      Expanded(flex:1,child:Container() ,),
                      Text(' '),
                    ],
                  ),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)),
                        border: Border.all(width: 0.5, color: Colors.grey,)),)
                ],)
            ],
          ),),)
      ],
    );
  }
}
