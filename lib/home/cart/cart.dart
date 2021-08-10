import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/my_project_important/parvaneh_gallery/flutter_mobile/lib/core/checkprice.dart';
import 'package:flutter_app/home/cart/cart_item.dart';
import 'package:flutter_app/home/orders/order_one_item.dart';
import 'package:flutter_app/home/orders/orders.dart';
import 'package:flutter_app/core/socket_handle.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import  'package:persian_number_utility/persian_number_utility.dart';

import 'model_cart.dart';



class cart extends StatefulWidget {
  socket_handle  connect_to_backend;
  cart({ @required this.connect_to_backend }) ;


  @override
  cartState createState() =>  cartState();
}

class  cartState extends State<cart> {
  @override
  void initState() {
    getcart();
    super.initState();
  }
  void getcart() async{
   await setState(() {
     widget.connect_to_backend.progress_cart=true;
    });
   await widget.connect_to_backend.get_cart().then((value) => (){


  });
   await   set_sum();
   await setState(() {
     widget.connect_to_backend.progress_cart=false;
   });

  }
TextEditingController address_cont=TextEditingController();
  int sum=0;
void set_sum(){
  print('summmm');
  sum=0;
  for(int i=0;i<widget.connect_to_backend.products_cart_list.length;i++){
    model_cart  data= widget.connect_to_backend.products_cart_list[i];
    sum+=int.parse( data.price.replaceAll(',', '')) *data.number;
  }
  setState(() {

  });
}
bool sum_progress=false;
  bool  progress=false;

  @override
  Widget build(BuildContext context) {

    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);

    return  MaterialApp(

        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
        ],  theme: ThemeData(fontFamily: 'meysam',
        primarySwatch: Colors.blue,accentColor: Colors.lightBlueAccent,primaryColor: Colors.lightBlueAccent
    ),
        locale: Locale("fa", "IR"),
        home:widget.connect_to_backend.progress_cart?
        Scaffold(body: Center(child: Container(width: 20,height: 20,
          child: CircularProgressIndicator(),),),):connect_to_backend.products_cart_list.length<1?
    Scaffold(backgroundColor: Colors.white,body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
      CachedNetworkImage(imageUrl: 'https://www.fashionstoopen.be/assets/images/empty-cart.png',),
   Row(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
     Text('سبد خرید شما خالیست')
   ],)
    ]
   ,)):
        Scaffold(backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle:true,elevation: 0,title: Text('سبد خرید',style: TextStyle(color: Colors.black87,
              fontSize: 14),),),
          body:
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: 10 ),
          child:SingleChildScrollView(child:
          Column(children: [
            Container(padding: EdgeInsets.symmetric(horizontal: 5),
              height: 60,
              child: Row(children: [
                Text(' جهت حذف هر آیتم را به سمت راست بکشید',style: TextStyle(color: Colors.black87,
                    fontSize: 12),),
              ],),),
            ListView.builder(
              itemCount:  connect_to_backend.products_cart_list.length,shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                model_cart  data=  connect_to_backend.products_cart_list[index]  ;

              return  Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    key: Key( data.item_id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) async{
                      await   connect_to_backend.products_cart_list.removeAt(index);

                      await    setState(() {
                        sum_progress=true;
                      });
                      await     connect_to_backend.add_to_cart(data.item_id, 'remove').then((value)async {

                        sum_progress=false;
 await     set_sum();

                      });

                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          Image.asset('assets/bin.png',color: Colors.white,)
                        ],
                      ),
                    ),
                    child: cart_item(item:  data,
                      connect_to_backend: connect_to_backend,pre_class: this,index: index,),
                  ),
                );
              }


                  ,
            ),

            Container(padding: EdgeInsets.symmetric(horizontal: 40),
              height: 80,
              child: Row(children: [
              Text(' مبلغ قابل پرداخت',style: TextStyle(color: Colors.black87,
                  fontSize: 14),),Expanded(child: Container(),),
                sum_progress?Container(width: 20,height: 20,child: CircularProgressIndicator(),):
                Text(sum.toString().seRagham(separator: ",")+' تومان ',style: TextStyle(color: Colors.black87,
                    fontSize: 14),)
            ],),),
            Theme(
        data:   ThemeData(
        primaryColor: Colors.redAccent,
          primaryColorDark: Colors.red,
        ),
          child:   TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 6,minLines: 5,controller: address_cont,
            decoration:   InputDecoration(
                border:   OutlineInputBorder(
                    borderSide:   BorderSide(color: Colors.teal)),
                hintText: 'در صورت خالی گذاشتن این فیلد آدرس همان آدرس پروفایل خواهد بود',
                helperText: 'آدرس را وارد کنید',hintStyle: TextStyle(fontSize: 12),
                labelText: 'آدرس',
                prefixIcon:   Icon(
                  Icons.location_city,
                  color: Colors.green,
                ),
                prefixText: ' ',
                suffixText: '',
                suffixStyle:   TextStyle(color: Colors.green)),
          ),
            )

          ],)
         ,) ,
        ),

          bottomNavigationBar: InkWell(
          onTap: ()async{

            await setState(() {
             progress =true;
            });
            await  connect_to_backend.order_send(address_cont.text, context);
            await setState(() {
              progress =false;
            });
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
              progress?Container(width: 20,height: 20,child: CircularProgressIndicator(backgroundColor: Colors.white,),):
              Text('سفارش',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                  fontSize: 14),)
            ],),) ,) 
          ,)  );
  }

}
