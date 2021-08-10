import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/defines.dart';
import 'package:flutter_app/core/socket_handle.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import '../home.dart';

class product_detail extends StatefulWidget {
  socket_handle  connect_to_backend;
  var item;
  product_detail({Key key,@required this.item,@required this.connect_to_backend})  ;

  @override
  _product_detailState createState() => _product_detailState();
}

class _product_detailState extends State<product_detail> with TickerProviderStateMixin {
  List images=[];
  @override
  void initState() {

      images= widget.item['items'];
      for(int i=0;i<images.length;i++){
        if(!images[i].toString().contains('.')){
          images.removeAt(i);
        }

      }
      setState(() {

      });
    super.initState();
      get_number_cart_req();

  }
  void get_number_cart_req() async{
    await  setState(() {
progress=true;

    });
    await widget.connect_to_backend.get_number_cart(  widget.item['_id'].toString()).then((value) {
      number=value;
    });
    await  setState(() {
progress=false;
    });
  }

  GlobalKey<ScaffoldState> _scaffoldKey =   GlobalKey<ScaffoldState>();

  bool progress=false;
  String number='0';
@override
Widget build(BuildContext context) {
  final connect_to_backend = Provider.of<socket_handle>(context, listen: true);
  return Scaffold(key: _scaffoldKey,
    appBar: AppBar(
      centerTitle: true,elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          size: 40.0,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Colors.white,
      title: Text(
       widget.item['name'].toString(),
        style: TextStyle(
          color: Colors.black,fontSize: 14
        ),
      ),
    ),
    body: _buildProductDetailsPage(context),
    bottomNavigationBar: Container(
    width: MediaQuery.of(context).size.width,
    height: 50.0,
    child:progress?Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(height: 20,width: 20,child: CircularProgressIndicator(),)
      ],):
    number=='0' ||  number=='no_cart' ||  number=='no'?
    Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
          flex: 2,
          child:Container(child:
          RaisedButton(
            onPressed: () {
              setState(() {
                progress=true;
              });
              connect_to_backend.add_to_cart(widget.item['_id'], 'add',).then((value) {
                setState(() {
                  number=value;
                  progress=false;
                });
              });
            },
            color: Colors.redAccent,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Icon(
                  //   Icons.add,
                  //   color: Colors.white,size: 20,
                  // ),
                  // SizedBox(
                  //   width: 4.0,
                  // ),
                  Text(
                    "افزودن به سبد",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),padding: EdgeInsets.all(5),) ,
        ),
      ],
    ): Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
       Expanded(flex:1,child:Center(child: InkWell(onTap: (){
         setState(() {
           progress=true;
         });
         connect_to_backend.add_to_cart(widget.item['_id'], 'add',).then((value) {
           setState(() {
             number=value;
             progress=false;
           });
         });
       },child: Icon(Icons.add,color: Colors.redAccent),),) ,),
        Expanded(flex:2,child:Center(child: Text(number,style: TextStyle(color: Colors.redAccent,fontSize: 20),),) ,),
        Expanded(flex:1,child:Center(child: InkWell(onTap: (){
          setState(() {
            progress=true;
          });
          connect_to_backend.add_to_cart(widget.item['_id'], 'mines', ).then((value) {
            setState(() {
              number=value;
              progress=false;
            });
          });
        },child: Icon(number=='1'?Icons.restore_from_trash:Icons.remove,color: Colors.redAccent),),) ,),
      ],
    ),
  ) ,
  );
}

_buildProductDetailsPage(BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;

  return ListView(
    children: <Widget>[
      Container(
        padding:  EdgeInsets.all(2.0),
        child: Card(
          elevation: 4.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildProductImagesWidgets(),
              _buildProductTitleWidget(),
              SizedBox(height: 4.0),
              _buildPriceWidgets(),

              SizedBox(height: 4.0),
              _buildStyleNoteData(),
              SizedBox(height: 20.0),
              _buildMoreInfoHeader(),
              SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ],
  );
}

_buildProductImagesWidgets() {
  TabController imagesController =
  TabController(length: images.length , vsync: this);

  return Padding(
    padding:   EdgeInsets.all(0.0),
    child: Container(
      height: 250.0,
      child: Center(
        child: DefaultTabController(
          length: images.length ,
          child: Stack(
            children: <Widget>[
              TabBarView(
                controller: imagesController,
                children:  images.map((path) =>  Image.network(
                  defines().image_folder+path ,fit: BoxFit.fill,
                )).toList() ,
              ),
              Container(   padding:   EdgeInsets.all(16.0),
                alignment: FractionalOffset(0.5, 0.95),
                child: TabPageSelector(
                  controller: imagesController,
                  selectedColor: Colors.grey,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

_buildProductTitleWidget() {
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: 12.0,vertical: 15),
    child: Center(
      child: Text(
        //name,
       widget.item['name'].toString(),
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    ),
  );
}



_buildStyleNoteData() {
  return Padding(
    padding:  EdgeInsets.only(
      right: 12.0,
    ),
    child: Text(
      widget.item['dsc'].toString() == null
          ? "Details unavailable"
          :  widget.item['dsc'].toString(),
      style: TextStyle(
        color: Colors.grey[600],
      ),
    ),
  );
}


  _buildPriceWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "${widget.item['price2'].toString()}"+ ' تومان ',
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
          SizedBox(
            width: 8.0,
          ),
          SizedBox(
            width: 8.0,
          ),
    //       Text(
    //         " % Off "  +  (( ((double.parse(  widget.item['price1'].toString().replaceAll(',', ''))-double.parse( widget.item['price2'].toString().replaceAll(',', '')))
    // / double.parse(  widget.item['price1'].toString()))*100).toString()).split('.')[0].toString()
    //          ,
    //         style: TextStyle(
    //           fontSize: 12.0,
    //           color: Colors.blue[700],
    //         ),
    //       ),
        ],
      ),
    );
  }
_buildMoreInfoHeader() {
  return Padding(
    padding:  EdgeInsets.only(
      right: 12.0,
    ),
    child: Html(
      data: widget.item['description'].toString() ,customTextAlign: (_) => TextAlign.right,) ,
  );
}

}