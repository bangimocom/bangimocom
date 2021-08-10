import 'dart:async';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/defines.dart';
import 'package:flutter_app/home/cart/cart.dart';
import 'package:flutter_app/home/cart/model_cart.dart';
import 'package:flutter_app/home/home.dart';
import 'package:flutter_app/home/orders/orders.dart';
import 'package:flutter_app/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:smart_select/smart_select.dart';

import 'checkprice.dart';


class socket_handle with ChangeNotifier {

  void change_data(){
    notifyListeners();
  }
  TabController tab_controller;
BuildContext main_context;
BuildContext offstage_context;

  void search_total(String word,int min,int record_counts)async{
if(tab_controller.index==0){
 await search_user(word, min, record_counts);
}else if(tab_controller.index==1){
}
  }
List  search_user_list=[];
  void search_user(String word,int min,int record_counts) async{
    print('search_user');
    var client =  http.Client();
    await  client.post(Uri.encodeFull(defines().request_url),  body: {
      "command": "search_user",
      "min":min.toString(),
      "record_counts":record_counts.toString(),
      "word":word
    }).then((response) {
      client.close();
      if (  response.statusCode == 200) {
        search_user_list.clear();
        search_user_list.addAll(json.decode(utf8.decode(response.bodyBytes)));
     //   print('search_user_list : '+json.decode(utf8.decode(response.bodyBytes)));
        change_data();
      }


    }).catchError((onError) {
      client.close();
      print("Error: $onError");
    });
  }


  List  products_list=[];
  Future<List> get_products(String search,int min,int record_counts) async{
    print('get_products');
    var client =  http.Client();
    await  client.post(Uri.encodeFull(defines().request_url),  body: {
      "command": "get_products",
      "min":min.toString(),
      "record_counts":record_counts.toString(),
      "mobile":my_phone,
      "search":search
    }).then((response) async{
      client.close();
      if (  response.statusCode == 200) {

        products_list=[];
        products_list.addAll(json.decode(utf8.decode(response.bodyBytes)));
       print(json.decode(utf8.decode(response.bodyBytes)));

      }


    }).catchError((onError) {
      client.close();
      print("Error: $onError");
    });
    return products_list;
  }

  List   cat_product_list=[];
  Future<List> get_cat_product(String search,String category,int min,int record_counts) async{
    print('get_cat_product');
    var client =  http.Client();
    await  client.post(Uri.encodeFull(defines().request_url),  body: {
      "command": "get_cat_product",
      "min":min.toString(),
      "record_counts":record_counts.toString(),
      "category":category,
      "mobile":my_phone,
      "search":search
    }).then((response) {
      client.close();
      if (  response.statusCode == 200) {
        cat_product_list=[];
        cat_product_list.addAll(json.decode(utf8.decode(response.bodyBytes)));
        print(json.decode(utf8.decode(response.bodyBytes)));

      }


    }).catchError((onError) {
      client.close();
      print("Error: $onError");
    });
    return  cat_product_list;
  }


  Future<String> get_number_cart(String _id, ) async{
    print('get_number_cart');
    String number='0';
    var client =  http.Client();
    await  client.post(Uri.encodeFull(defines().request_url),  body: {
      "command": "get_number_cart",
      "_id":_id,
      "mobile":my_phone,
    }).then((response) {
      client.close();
      if (  response.statusCode == 200) {
        number=utf8.decode(response.bodyBytes);
        print(json.decode(utf8.decode(response.bodyBytes)));

      }


    }).catchError((onError) {
      client.close();
      print("Error: $onError");
    });
    return  number;
  }


  List   cat_for_user_list=[];
  void get_cat_for_user( int min,int record_counts) async{
    print('get_cat_for_user');
    var client =  http.Client();
    await  client.post(Uri.encodeFull(defines().request_url),  body: {
      "command": "get_cat_for_user",
      "mobile":my_phone,
    }).then((response) {
      client.close();
      if (  response.statusCode == 200) {
        cat_for_user_list.clear();
        cat_for_user_list.addAll(json.decode(utf8.decode(response.bodyBytes)));
        print(json.decode(utf8.decode(response.bodyBytes)));

      }


    }).catchError((onError) {
      client.close();
      print("Error: $onError");
    });
  }
  List  home_list=[];
  void home_request(int min,int record_counts,) async{
    print('home_request');
    var client =  http.Client();
    await  client.post(Uri.encodeFull(defines().request_url),  body: {
      "command": "home_request",
      "mobile":my_phone,
      "record_counts":record_counts.toString(),
      "min":min.toString(),

    }).then((response) {
      client.close();
      if (  response.statusCode == 200) {
          home_list=[];
        home_list.addAll(json.decode(utf8.decode(response.bodyBytes)));
        print(json.decode(utf8.decode(response.bodyBytes)));
      }


    }).catchError((onError) {
      client.close();
      print("Error: $onError");
    });
  }


  String my_phone;

  SharedPreferences prefs;
  String active  ;
  GlobalKey<ScaffoldState> scaff = GlobalKey<ScaffoldState>();




  Future<bool>    edit_image_profile( String  path ,BuildContext context ) async{
    var request = await http.MultipartRequest("POST", Uri.parse(defines().request_url));
    request.fields["command"] = 'edit_image_profile';
    request.fields["mobile"] = my_phone;

      await request.files.add(await http.MultipartFile.fromPath("file", path,filename: 'profile.png'));

    var response = await request.send();
    await response.stream.toBytes().then((value) {
      if(String.fromCharCodes(value)=='yes'){
print('sssssssssss');
        return true;
      }
    });

       return    false;
  }



  Future<String> add_to_cart(String product_id ,String type  ) async{
    print('add_to_cart');
    var client =  http.Client();
    String res='';
    await  client.post(Uri.encodeFull(defines().request_url),  body: {
      "command": "add_to_cart",
   "mobile": my_phone,
   "product_id":product_id,
      "role":home_list[1]['role'].toString(),
   "type":type,
    }).then((response) async{
      client.close();
      if (  response.statusCode == 200) {
if(utf8.decode(response.bodyBytes)=='no_cart'){
  AwesomeDialog(
    context: main_context,
    dialogType: DialogType.INFO,
    animType: AnimType.BOTTOMSLIDE,
    title: 'در انتظار تایید',
    desc: 'بعد از تایید سفارش قبلی سفارش جدید دهید',

  )..show();
}
      res= utf8.decode(response.bodyBytes);
//          print(json.decode(utf8.decode(response.bodyBytes)));
//         change_data();
      }

    }).catchError((onError) {
      client.close();
      return res;
      print("Error: $onError");
    });

    return res;
  }




  bool inprogress=false;
  List cart_list=null;
String level='0';

  bool  progress_cart=false;
  Future<bool> get_cart() async {
    cart_list=null;
    products_cart_list=[];

    print('get_cart');
    var client =  http.Client();
    await  client.post(Uri.encodeFull(defines().request_url),  body: {
      "command": "get_cart",
      "mobile": my_phone,
    }).then((response) async{

           cart_list=[];
      await    client.close();
      if (  response.statusCode == 200)  {
           await  cart_list.clear();
           await     cart_list.addAll(json.decode(utf8.decode(response.bodyBytes)));

        print(cart_list[0].toString());
           await    fill_cart_list();
 return    true;
      }

      return false;
    }).catchError((onError) {

      client.close();
      print("Error: $onError");
      return false;
    });
//    Timer.periodic(
//      Duration(seconds: 8),
//          (Timer timer) async{
//
//
//
//
//          }
//    );


  }
List orders_one_userlist=null;
  Future<bool> get_orders_one_user(order_id) async {
    orders_one_userlist=null;
    print('get_orders_one_user');
    var client =  http.Client();
    await  client.post(Uri.encodeFull(defines().request_url),  body: {
      "command": "get_orders_one_user",
      "order_id": order_id,
    }).then((response) async{

      orders_one_userlist=[];
      client.close();
      if (  response.statusCode == 200) {
        orders_one_userlist.clear();
        orders_one_userlist.addAll(json.decode(utf8.decode(response.bodyBytes)));

        print(orders_one_userlist.toString());
        return    true;
      }

      return false;
    }).catchError((onError) {

      client.close();
      print("Error: $onError");
      return false;
    });
//    Timer.periodic(
//      Duration(seconds: 8),
//          (Timer timer) async{
//
//
//
//
//          }
//    );


  }


  List orders_list=null;
  Future<bool> get_orders_list() async {
    orders_list=null;
    print('get_orders_list');
    var client =  http.Client();
    await  client.post(Uri.encodeFull(defines().request_url),  body: {
      "command": "get_orders_user",
      "mobile": my_phone,
    }).then((response) async{

      orders_list=[];
      client.close();
      if (  response.statusCode == 200) {
        orders_list=[];
        orders_list.addAll(json.decode(utf8.decode(response.bodyBytes)));

        print(orders_list .toString());
        return    true;
      }

      return false;
    }).catchError((onError) {

      client.close();
      print("Error: $onError");
      return false;
    });
//    Timer.periodic(
//      Duration(seconds: 8),
//          (Timer timer) async{
//
//
//
//
//          }
//    );


  }

  Future<bool> order_send(String address,context) async {

    print('order_send');
    var client =  http.Client();
    await  client.post(Uri.encodeFull(defines().request_url),  body: {
      "command": "order_set_level",
      "address": address,
      "mobile": my_phone,
    }).then((response) async{

      client.close();
      if (  response.statusCode == 200) {
        if(utf8.decode(response.bodyBytes)=='yes'){

          showDialog(
            barrierDismissible: false,context: context,builder: (context){
            return  AlertDialog(contentPadding: EdgeInsets.all(10),
                content: Wrap(
                  children: <Widget>[
                    Text('سفارش شما با موفقیت ارسال شد .\n لطفا تا تایید کامل منتظر بمانید \n به شما اطلاع داده خواهد شد'),
                    InkWell(child: Container(
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
                        Text(' تایید',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                            fontSize: 14),)
                      ],),),onTap: (){
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (contextme) => home() ),
                            (Route<dynamic> route) => false,
                      );
                    },)
                  ],
                ),
            );
          },);
        }
        return    true;
      }

      return false;
    }).catchError((onError) {

      client.close();
      print("Error: $onError");
      return false;
    });
//    Timer.periodic(
//      Duration(seconds: 8),
//          (Timer timer) async{
//
//
//
//
//          }
//    );


  }


  Future<bool> change_level(String level,String order_id,context) async {

    print('change_level');
    var client =  http.Client();
    await  client.post(Uri.encodeFull(defines().request_url),  body: {
      "command": "order_change_level",
      "level": level,
      "order_id": order_id,
      "mobile": my_phone,
    }).then((response) async{

      client.close();
      if (  response.statusCode == 200) {
        if(utf8.decode(response.bodyBytes)=='yes'){

if(level=='0'){

  Navigator
      .of(context)
      .push(MaterialPageRoute(builder: (_) => cart(connect_to_backend: this,)));
}else if(level=='2'){
  Navigator.pushAndRemoveUntil(
    context ,
    MaterialPageRoute(builder: (contextme) => orders(connect_to_backend: this)),
        (Route<dynamic> route) => false,
  ); 
}
        }
        return    true;
      }

      return false;
    }).catchError((onError) {

      client.close();
      print("Error: $onError");
      return false;
    });


  }


String lat='12.14';
  String lan='124.14';
  Future<bool> edit_profile_req(String address,String name,String manager_name
      ,String post_code,String city ,String state  ,context) async {

    print('edit_profile_req');
    var client =  http.Client();
    await  client.post(Uri.encodeFull(defines().request_url),  body: {
      "command": "edit_profile_req",
      "address": address,
      "mobile": my_phone,
      "name": name,
      "lat": lat,
      "lan": lan,
      "manager_name": manager_name,
      "post_code": post_code,
      "city": city,
      "state": state,
    }).then((response) async{

      client.close();
      if (  response.statusCode == 200) {
        if(utf8.decode(response.bodyBytes)=='yes'){


        }
        return    true;
      }

      return false;
    }).catchError((onError) {

      client.close();
      print("Error: $onError");
      return false;
    });
//    Timer.periodic(
//      Duration(seconds: 8),
//          (Timer timer) async{
//
//
//
//
//          }
//    );


  }


  void show_snackbar(String text,_scaffoldKey) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(Icons.fiber_manual_record),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              text,style: TextStyle(fontFamily: 'meysam'),
            ),
          ),
        ],
      ),
    ));
  }

  void first_requests(int min,int record_count) async {
    prefs = await SharedPreferences.getInstance();
    my_phone= await prefs.getString("mobile");
    active = await prefs.getString('token');

    await  home_request(min,record_count);
    if( home_list[1]['role'].toString()=='visitor'){
      await   get_galleries();
    }
  }



  List<model_cart> products_cart_list=[];
  void fill_cart_list(){
    print('summmm');
    for(int i=0;i< cart_list.length;i++){
      List  data=json.decode(  cart_list[i] );
      print( cart_list[i].toString());
      products_cart_list.add(model_cart(  product_id: data[0]['product_id'],
           order_id: data[0]['order_id'].toString(),number: data[0]['number'],
          price:  checkprice(connect_to_backend: this ,
              price1: data[1]['price1'].toString()
              , price2: data[1]['price2'].toString()).check() ,
          item_id:data[0]['_id'].toString(), name:  data[1]['name'].toString(),
          category: data[1]['category'].toString(),
          post_price: data[1]['post_price'].toString(), description: data[1]['description'].toString()
          , items: data[1]['items'] , dsc: data[1]['dsc'].toString(),
          timeStamp: data[1]['timeStamp'].toString()),) ;
    }

  }

  void logout() async {
    await  prefs.remove('token');
    Navigator.pushAndRemoveUntil(
      main_context,
      MaterialPageRoute(builder: (contextme) => MaterialApp(

        home: login(),)),
          (Route<dynamic> route) => false,
    );

  }




  List galleries_list=null;
  List<SmartSelectOption<String>> options = [];
  String title='اکانت خودتان';
  Future<bool> get_galleries() async {
    galleries_list=null;
    print('get_galleries_list');
    var client =  http.Client();
    await  client.post(Uri.encodeFull(defines().request_url),  body: {
      "command": "get_galleries",
    }).then((response) async{

      galleries_list=[];
      client.close();
      if (  response.statusCode == 200) {
        galleries_list=[];
        galleries_list.addAll(json.decode(utf8.decode(response.bodyBytes)));
        options=[];

        my_phone= await prefs.getString("mobile");
        await  options.add(SmartSelectOption<String>(value: my_phone, title: title))  ;
        for(var i=0;i<galleries_list.length;i++){
          options.add(SmartSelectOption<String>(value: galleries_list[i]['mobile'], title: galleries_list[i]['name']));
        }

        print(galleries_list.toString());
      }

      change_data();
      return false;
    }).catchError((onError) {

      client.close();
      print("Error: $onError");
      return false;
    });
//    Timer.periodic(
//      Duration(seconds: 8),
//          (Timer timer) async{
//
//
//
//
//          }
//    );


  }


}