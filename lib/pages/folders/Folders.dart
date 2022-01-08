
import 'package:flutter/material.dart';
import 'package:flutter_app/BackButton.dart';
import 'package:flutter_app/core/socket_handle.dart';
import 'package:flutter_app/pages/HomePage.dart';
import 'package:flutter_app/pages/folders/Folder.dart';
import 'package:flutter_app/pages/folders/Video.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Folders extends StatefulWidget {
  socket_handle connect_to_backend;
  String category;
  List items;
  String title_appbar;
    Folders({key,@required this.connect_to_backend,
      @required this.category,@required this.items,@required this.title_appbar}) : super(key: key);

  @override
  _FoldersState createState() => _FoldersState();
}

class _FoldersState extends State<Folders> {
  // @override
  // void initState() {
  //   super.initState();
  //   fill_items();
  //
  // }
  //
  // void fill_items()async{
  //   items=[];
  //   for(int i=0;i< widget.connect_to_backend.categories_list.length ;i++){
  //     if(widget.connect_to_backend.categories_list[i]['parent']==widget.category){
  //
  //       await      items.add(widget.connect_to_backend.categories_list[i]);
  //
  //     }
  //   }
  //   for(int i=0;i< widget.connect_to_backend.videos_list.length ;i++){
  //     if(widget.connect_to_backend.videos_list[i]['category']==widget.category){
  //
  //      await   items.add(widget.connect_to_backend.videos_list[i]);
  //     }
  //   }
  //   items.sort((a, b) {
  //     return  a['name'].toString()  .compareTo( b['name'].toString() );
  //   } );
  //
  //   await   setState(() {
  //
  //   });
  // }
@override
  void initState() {
  try{
    sort_items();

  }catch(e){}
    super.initState();
  }
  void sort_items()async{
    if(widget.category=='section'){
      try{
        await  widget.items.sort((a, b) {

          return  int.parse( a['section_order'].toString() )  .   compareTo( int.parse(b['section_order'].toString()) );
        } );
      }catch(e){

      }

    }else if(widget.category=='course'){
      try{
        await     widget.items.sort((a, b) {
          return  int.parse( a['sort'].toString() )  .   compareTo( int.parse(b['sort'].toString()) );
        } );
      }catch(e){

      }

    }
    await    setState(() {

    });
}

  @override
  Widget build(BuildContext context) {
    return    widget.connect_to_backend.orderinfo_list==null ? Center(child: Container(width: 20,height: 20,child:
    CircularProgressIndicator(color: Colors.blue,),),) :
    widget.connect_to_backend.orderinfo_list.length<1?
    Column(
      mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Image.network('https://cdn-icons-png.flaticon.com/512/5093/5093501.png',
        height: 100,) ,
        Container(height: 20,  ),
      Container(height: 20,child: Text('You do not have an order'),)
    ],)
    : Column(children: [

      Container(
        height: 85,
        alignment: Alignment.topCenter,
        width: double.infinity,
        child:
        Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(height: 40,color: Colors.transparent,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('      '),
                     Expanded(child:
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                     widget.category=='order'?Container(): Back__Button(cc: context,),

                   ],)
                     ) ,
                    ],),),
                  // ColorizeAnimatedTextKit(
                  //   isRepeatingAnimation: true,pause: Duration(seconds: 0),
                  //   repeatForever: true,
                  //   onTap: () {
                  //     print("Tap Event");
                  //   },
                  //   text: [
                  //     'EnglishTurbo',
                  //   ],
                  //   textStyle:  TextStyle(
                  //     fontSize: 16,
                  //     color: Colors.white,fontStyle: FontStyle.italic,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  //   colors: [
                  //     Colors.purple[200],
                  //     Colors.blue[200],
                  //     Colors.yellow[200],
                  //     Colors.red[200],
                  //   ],
                  // ),
                    Image.asset('assets/asatir.png',height: 30,)

                  ,
                  Expanded(child:Container(),),
// Text(' '),
//                    Image.asset('images/minilogo.png',height: 20,),
                ],)],
          ),


        ],),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
      widget.category=='order'?Container():  Container(padding: EdgeInsets.all(20),child:
    Column(children: [
      Directionality(textDirection: TextDirection.rtl, child: Text(
        widget.title_appbar==''?'بدون عنوان':  widget.title_appbar, style: TextStyle(fontSize: 12),))
    ],)
      ,)
    ,
      Expanded(child: ListView.builder(
        // gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemCount:   widget.items.length ,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all( MediaQuery.of(context).size.width*0.02),
        shrinkWrap: false,
        itemBuilder: (BuildContext context, int index) {
          // print('print: '+items[index]['parent'].toString());

          return  Container(
              margin: EdgeInsets.all( MediaQuery.of(context).size.width*0.01),
              child:
              widget.category=='order' ?
              Folder(connect_to_backend: widget.connect_to_backend,
                item: widget.items[index] , category: 'order',):
              widget.category=='section' ?
              Folder(connect_to_backend: widget.connect_to_backend,
                item: widget.items[index] , category: 'section',):
              Video(connect_to_backend: widget.connect_to_backend,
                item: widget.items[index],title_appbar: 'course',)
          )

          ;
        },

      ) )

    ],)
   ;
  }
}
