
import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/home/product_list.dart';
import 'package:flutter_app/core/socket_handle.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ripple_effect/ripple_effect.dart';



class search extends StatefulWidget {
  socket_handle  connect_to_backend;
  search({Key key, this.title,@required this.connect_to_backend }) : super(key: key);

  final String title;

  @override
  _searchState createState() =>  _searchState();
}

class _searchState extends State<search> {

List search_list=null;
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
            await widget.connect_to_backend.get_products(search_cont.text, min, record_count );
              search_list .addAll(  widget.connect_to_backend.products_list)  ;
              print(search_list.length.toString());
            await setState(() {
              inprog = true;
            });
          }
        }
      });

    get_search();
    super.initState();
  }
void get_search() async{
    await widget.connect_to_backend.get_products(search_cont.text, min, record_count).then((value) {
      search_list=value;
    });
    await  setState(() {

    });
}

TextEditingController  search_cont=TextEditingController();
RefreshController _refreshController = RefreshController(initialRefresh: false);
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
      Expanded(child:TextField(autofocus: true,controller: search_cont,
        decoration: InputDecoration(hintText: 'جستجو ..',hintStyle: TextStyle(color: Colors.grey)
            ,border: InputBorder.none
        ),onSubmitted: (val)async{
          await  setState(() {
search_list=null;
min=0;
          });
          await widget.connect_to_backend.get_products(val, min, record_count).then((value) {
search_list=value;
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

        search_list==null?
        Center(child: Container(width: 30,height: 30,child:
        CircularProgressIndicator(backgroundColor: Colors.black,)
          ,),) :search_list.length<1?Center(child: Text('nothing'),):
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

    await widget.connect_to_backend.get_products(search_cont.text, min, record_count).then((value) {
      search_list=value;
    });
    print('on ref');
    await   _refreshController.refreshCompleted();
    } ,
    child:  ListView.builder(
      shrinkWrap: true,
      padding:  EdgeInsets.all(0.0),
      scrollDirection: Axis.vertical,controller: _scrollController,
      itemCount: search_list.length,
      itemBuilder: (BuildContext content, int index) {
        return  AwesomeListItem(
          id: search_list[index]['_id'].toString(),
          name: search_list[index]['name'].toString(),
          color: COLORS[ Random().nextInt(18)],
          category: search_list[index]['category'].toString(),
          price1: search_list[index]['price1'].toString(),
          price2: search_list[index]['price2'].toString(),
          post_price: search_list[index]['post_price'].toString(),
          description: search_list[index]['description'].toString(),
          items: search_list[index]['items'],
          dsc: search_list[index]['dsc'].toString(),
          timeStamp: search_list[index]['timeStamp'].toString(),
          item: search_list[index] ,
        ) ;
      },
    ) )


      ,);
  }
}



