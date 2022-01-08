
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/socket_handle.dart';

import 'videodetails/VideoDetails.dart';

class Video extends StatefulWidget {
  socket_handle connect_to_backend;
  var item;
  String title_appbar;
  Video({@required this.connect_to_backend,@required this.item,@required this.title_appbar});
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {

  @override
  void initState() {
    print('title_appbar : '+widget.title_appbar);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return    Container(padding: EdgeInsets.all(10),
      decoration: BoxDecoration( color: Colors.grey.withOpacity(0.2,),
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
          Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (_) => VideoDetails(connect_to_backend: widget.connect_to_backend,item: widget.item,)));
        },
        child:  ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child:   Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Image.asset('images/video.png' ,width: MediaQuery.of(context).size.width*0.1
                ,height:  MediaQuery.of(context).size.width*0.1,color: Colors.blue,),
              Text('    '),

              Expanded(child:
              SingleChildScrollView(child:    Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Text(
                  widget.item['post_title'].toString(),
                  style: TextStyle(fontSize: 12,color: Colors.grey[900],fontFamily: 'meysam'   ,),
                  textAlign: TextAlign.right,
                )
              ],))
              )

            ],) ,)  ,)

      ,
    );
  }
}
