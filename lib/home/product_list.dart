import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/defines.dart';
import 'file:///C:/my_project_important/parvaneh_gallery/flutter_mobile/lib/core/checkprice.dart';
import 'package:flutter_app/core/socket_handle.dart';
import 'package:flutter_app/home/product_detail/product_detail.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home.dart';

class product_list extends StatefulWidget {
  GlobalKey<ScaffoldState> drawerKey;

  socket_handle  connect_to_backend;
  product_list({@required this.drawerKey,@required this.connect_to_backend });
  @override
  State<StatefulWidget> createState() {
    return new product_list_page();
  }

}

var COLORS = [
  Color.fromARGB(255,230, 128, 128),
  Color.fromARGB(255,230, 150, 128 ),
  Color.fromARGB(255,230, 164, 128 ),
  Color.fromARGB(255,230, 191, 128  ),
  Color.fromARGB(255,230, 209, 128 ),
  Color.fromARGB(255,230, 227, 128  ),
  Color.fromARGB(255,215, 230, 128 ),
  Color.fromARGB(255,187, 230, 128),
  Color.fromARGB(255,130, 230, 128  ),
  Color.fromARGB(255,128, 230, 165  ),
  Color.fromARGB(255,128, 230, 226  ),
  Color.fromARGB(255,128, 186, 230),
  Color.fromARGB(255,128, 133, 230 ),
  Color.fromARGB(255,178, 128, 230 ),
  Color.fromARGB(255,230, 128, 227  ),
  Color.fromARGB(255,230, 128, 183 ),
  Color.fromARGB(255,230, 128, 144 ),
  Color.fromARGB(255,230, 128, 129 ),
];
class product_list_page extends State<product_list> {
  ScrollController  scrollController =  ScrollController()  ;
  int min=0;
  int record_count=20;
  List products_list ;
  @override
  void initState() {
    products_list= widget.connect_to_backend.home_list[0];
    setState(() {

    });
    bool inprog = true;
    scrollController
      ..addListener(() async {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          if (inprog == true) {
            inprog = false;
            min += record_count;
            await widget.connect_to_backend.home_request(min, record_count);
            print('down');

            products_list.addAll(  widget.connect_to_backend.home_list[0]) ;
            await setState(() {
              inprog = true;
            });
          }
        }
      });
  }

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {


    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);

    return
    Transform.translate(
      offset:  Offset(0.0, MediaQuery.of(context).size.height * 0.1050),
      child: Container(margin: EdgeInsets.only(top: 10,bottom: 40),child:  SmartRefresher(
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
          await   products_list.clear();
          min=0;

          await    widget.connect_to_backend.home_request(min, record_count);
          await      products_list.addAll(  widget.connect_to_backend.home_list[0]) ;
    print('on ref');
    await   _refreshController.refreshCompleted();
    } ,
        child: ListView.builder(
          shrinkWrap: true,
          padding:  EdgeInsets.all(0.0),controller: scrollController,
          scrollDirection: Axis.vertical,
          itemCount: products_list.length,
          itemBuilder: (BuildContext content, int index) {
            return  AwesomeListItem(
              id: products_list[index]['_id'].toString(),
              name: products_list[index]['name'].toString(),
              color: COLORS[ Random().nextInt(18)],
              category: products_list[index]['category'].toString(),
              price1: products_list[index]['price1'].toString(),
              price2: products_list[index]['price2'].toString(),
              post_price: products_list[index]['post_price'].toString(),
              description: products_list[index]['description'].toString(),
              items: products_list[index]['items'],
              dsc: products_list[index]['dsc'].toString(),
              timeStamp: products_list[index]['timeStamp'].toString(),
              item: products_list[index] ,
            ) ;
          },
        ) ,
      ) ),
    )
     ;
  }

  @override
  void dispose() {
super.dispose();
  }

}

class AwesomeListItem extends StatefulWidget {
  String  id;
  String name;
  var color;
  var category;
  var price1;
  var price2;
  var post_price;
  String description;
  List items;
  String dsc;
  var timeStamp;
var item;
  AwesomeListItem({this.id, this.name , this.color, this.category
    , this.price1, this.price2, this.post_price, this.description, this.items
    , this.dsc, this.timeStamp, this.item,});

  @override
  _AwesomeListItemState createState() =>  _AwesomeListItemState();
}

class _AwesomeListItemState extends State<AwesomeListItem> {
  @override
  Widget build(BuildContext context) {
    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);

    return InkWell(child: Row(
      children: <Widget>[
        Container(width: 10.0, height: 190.0, color: COLORS[ Random().nextInt(18)]),
        Expanded(
          child:  Padding(
            padding:
            EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.name,
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: 16.0),
                  child:  Text(
                    widget.dsc,
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.only(top: 10.0),
                  child: Row(children: [
                    // Text(
                    //   (connect_to_backend.level=='1'?  widget.price1: widget.price2)+' تومان ',
                    //   style: TextStyle(
                    //       color: Colors.redAccent,decoration: TextDecoration.lineThrough,
                    //       fontSize: 7.0,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    Text(

                     checkprice(connect_to_backend: connect_to_backend , price1: widget.price1
                        , price2: widget.price2).check()
                          +' تومان ',
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    )    ,

                  ],),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 90.0,
          width: 90.0,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Transform.translate(
                offset:  Offset(10.0, 0.0),
                child:  Container(
                  height: 70.0,
                  width: 70.0,
                  color: widget.color,
                ),
              ),
              Transform.translate(
                offset: Offset(5.0, 10.0),
                child:  Card(
                  elevation: 20.0,
                  child:  Container(
                    height: 120.0,
                    width: 120.0,
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 2.0,
                            color: Colors.white,
                            style: BorderStyle.solid),
                        image: DecorationImage(
                          image: NetworkImage(
                              widget.items.length<2?'http://www.actbus.net/fleetwiki/images/8/84/Noimage.jpg':
                              defines().image_folder+
                              (widget.items[0].toString().contains('.')?widget.items[0].toString(): widget.items[1].toString())
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),onTap: (){

      Navigator
          .of(context)
          .push(MaterialPageRoute(builder: (_) => product_detail(item: widget.item,connect_to_backend: connect_to_backend,)));

    },) ;
  }
}