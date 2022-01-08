
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/socket_handle.dart';
import 'package:flutter_app/defines.dart';
import 'package:flutter_app/pages/folders/Video.dart';

import 'Folders.dart';



class Folder extends StatefulWidget {
  socket_handle connect_to_backend;
  var item;
  String  category;
  Folder({@required this.connect_to_backend,@required this.item,@required this.category});

  @override
  _FolderState createState() => _FolderState();
}

class _FolderState extends State<Folder> {
  @override
  Widget build(BuildContext context) {
   String category = widget.category=='order' ?
    widget.item['order']['order_name'].toString() :
    widget.item['detail_section']['section_name'].toString();

    return  Container(padding: EdgeInsets.all(10),
      decoration: BoxDecoration( color:Colors.grey.withOpacity(0.2,),
        borderRadius:  BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2,),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],),
      child:  InkWell(
          onTap: (){
            widget.category=='order' ?
            Navigator
                .of(context)
                .push(MaterialPageRoute(builder: (_) => Folders(connect_to_backend: widget.connect_to_backend,
              category:  'section',
              items: widget.item['sections'],title_appbar:  widget.item['order']['order_name'].toString()
              ,))) :
            Navigator
                .of(context)
                .push(MaterialPageRoute(builder: (_) => Folders(connect_to_backend: widget.connect_to_backend,
              category:  'course',
              items: widget.item['courses'],title_appbar:  widget.item['detail_section']['section_name'].toString()
              ,)));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Image.asset('images/folder2.png',color: Colors.blue ,width: 40
                  ,height:  40, ),
                Text('    '),
                Expanded(child:
                SingleChildScrollView(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                  Directionality(textDirection: TextDirection.ltr, child: Text(

                    category==''?'بدون عنوان':  category
                    ,
                    style: TextStyle(fontSize: 10,color: Colors.grey[900],fontFamily: 'meysam'   ),
                    textAlign: TextAlign.right,
                  ))
                ],),)
                )
                ,
              ],),) ),);
  }
}
