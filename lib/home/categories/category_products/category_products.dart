
import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/home/product_list.dart';
import 'package:flutter_app/core/socket_handle.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';



class category_products extends StatefulWidget {
  socket_handle  connect_to_backend;
  String category;
  String category_name;
  category_products({Key key, this.title,@required this.connect_to_backend
    ,@required this.category  ,@required this.category_name}) : super(key: key);

  final String title;

  @override
  _category_productsState createState() =>  _category_productsState();
}

class _category_productsState extends State<category_products> {
List product_list=null;
ScrollController  _scrollController =  ScrollController()  ;
int min=0;
int record_count=20;
@override
void initState() {
  bool inprog = true;
  _scrollController
    ..addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (inprog == true) {
          inprog = false;
          min += record_count;
          print('down');
          await widget.connect_to_backend.get_cat_product(search_cont.text,widget.category, min, record_count );
          product_list .addAll(  widget.connect_to_backend.products_list)  ;
          print(product_list.length.toString());
          await setState(() {
            inprog = true;
          });
        }
      }
    });
    get_cat_product_req();

    super.initState();
  }
  void get_cat_product_req() async{
    await widget.connect_to_backend.get_cat_product(  '',widget.category,min, record_count).then((value) {
      product_list=value;
    });
    await  setState(() {

    });
  }

RefreshController _refreshController = RefreshController(initialRefresh: false);
  TextEditingController  search_cont=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);

    return Scaffold(backgroundColor: Colors.white ,appBar: AppBar(
      automaticallyImplyLeading: false,
      title: Row(children: [
       InkWell(child: Icon(Icons.arrow_back,color: Colors.grey),onTap: (){
Navigator.pop(context);
      },),
      Text(' '),
      Expanded(child:TextField(autofocus: false,
        decoration: InputDecoration(hintText: 'جستجو در دسته بندی '+widget.category_name,
            hintStyle: TextStyle(color: Colors.grey,fontSize: 12)
            ,border: InputBorder.none
        ),controller: search_cont,onSubmitted: (val)async{
          await  setState(() {
product_list=null;
          });
      await widget.connect_to_backend.get_cat_product(val,widget.category, min, record_count).then((value) {
        product_list=value;
      });
      await  setState(() {

      });
      },
      ),),InkWell(child: Icon(Icons.close,color: Colors.grey),onTap: (){
search_cont.text='';
setState(() {

});
      },)
    ],),backgroundColor: Colors.white,),body:

        product_list==null?
        Center(child: Container(width: 30,height: 30,child:
        CircularProgressIndicator(backgroundColor: Colors.black,)
          ,),) : product_list.length<1?Center(child: Text('nothing'),):
    SmartRefresher(
    enablePullDown: true,
    enablePullUp: false,
    header: WaterDropHeader(complete: Image.asset('assets/logo.png',height: 40,),),
    footer: CustomFooter(
    builder: (BuildContext context,LoadStatus mode){
    Widget body ;
    if(mode==LoadStatus.idle){
    body =  Text("pull up load");
    }
    else if(mode==LoadStatus.loading){
    body =  CupertinoActivityIndicator();
    }
    else if(mode == LoadStatus.failed){
    body = Text("Load Failed!Click retry!");
    }
    else if(mode == LoadStatus.canLoading){
    body = Text("release to load more");
    }
    else{
    body = Text("No more Data");
    }
    return Container(
    height: 55.0,
    child: Center(child:body),
    );
    },
    ),
    controller: _refreshController,
    onRefresh: ()async{
    min=0;

    await widget.connect_to_backend.get_cat_product(search_cont.text,widget.category, min, record_count).then((value) {
    product_list=value;
    });
    print('on ref');
    await   _refreshController.refreshCompleted();
    } ,
    child: ListView.builder(
      shrinkWrap: true,
      padding:  EdgeInsets.all(0.0),
      scrollDirection: Axis.vertical,
      primary: true,
      itemCount: product_list.length,
      itemBuilder: (BuildContext content, int index) {
        return  AwesomeListItem(
          id: product_list[index]['_id'].toString(),
          name: product_list[index]['name'].toString(),
          color: COLORS[ Random().nextInt(18)],
          category: product_list[index]['category'].toString(),
          price1: product_list[index]['price1'].toString(),
          price2: product_list[index]['price2'].toString(),
          post_price: product_list[index]['post_price'].toString(),
          description: product_list[index]['description'].toString(),
          items: product_list[index]['items'],
          dsc: product_list[index]['dsc'].toString(),
          timeStamp: product_list[index]['timeStamp'].toString(),
          item: product_list[index] ,
        ) ;
      },
    )  )


      ,);
  }
}



