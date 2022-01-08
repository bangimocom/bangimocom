

import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:encrypt/encrypt.dart' as en;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/database_helper.dart';
import 'package:flutter_app/core/socket_handle.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sqflite/sqflite.dart';


import 'dart:async';

import 'package:flowder/flowder.dart';
import 'package:path_provider/path_provider.dart';

class DownloadVideo extends StatefulWidget {
  Database db;
 socket_handle connect_to_backend;
 String current_path_video;
  String sizefile;
 var item;
  Function falseresolotion;
 DownloadVideo({@required this.connect_to_backend,@required this.current_path_video
   ,@required this.db ,@required this.item,@required this.falseresolotion,@required this.sizefile});
  @override
  _DownloadVideoState createState() => _DownloadVideoState();
}

class _DownloadVideoState extends State<DownloadVideo> {

  StreamSubscription download_streem;
  double _progress = 0.01;
  get downloadProgress => _progress;
  void startDownloading() async {

    var date = await DateTime.now().millisecondsSinceEpoch.toString()+'.mp4';
    filename=date;
    await _getFile();
    final downloaderUtils = await DownloaderUtils(
      progressCallback: (current, total) {
        // final progress = (current / total) * 100;
        // print('Downloading: $progress');
        _progress = current / total;
        setState(() {
// print('_progress : '+_progress.toString());
        });
      },
      file: File('${dir.path}/$filename'),
      progress: ProgressImplementation(),
      onDone: () async{
        _progress = 0;
        await  setState(() {

        });
        String post_name= widget.item['post_name'].toString();
        Map<String, dynamic> row =  await  {
          DatabaseHelper.columnid : widget.item['ID'].toString(),
        DatabaseHelper.columnName  : widget.item['post_name'].toString(),
        DatabaseHelper.columnpath  :"${dir.path}/$filename"
        };
        print('inserted in'+"${dir.path}/$filename");
        await  _insert(row);
        await   setState(() {
        completed=true;
        });
        await   widget.falseresolotion();

        },
      deleteOnCancel: true,
    );

   await Flowder.download(
        widget.current_path_video,
        downloaderUtils);


    download_streem;
  }
  Future<String> _getFile() async {
    // dir = await getApplicationDocumentsDirectory();
    dir = await getExternalStorageDirectory();
    // print('dir : '+"${dir.path}/$filename");
    return  "${dir.path}/$filename";
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
  void _insert(   Map<String, dynamic> row ) async {
    final id = await widget.db.insert('videos', row).then((value) async{

      await    print('eeerrrorr :'+value.toString());
    }) ;
  }
  var dir;
  String filename;
bool inprogress=false;




bool completed=false;

  @override
  Widget build(BuildContext context) {
    return  completed ? Container():
    Column(children: [

      Container(
        width: 200,height: 70,
        padding: EdgeInsets.only(top: 10),
        child: !inprogress? Column(children: [
          InkWell(
            onTap: (){
              if(inprogress){
                inprogress=false;
                download_streem.cancel();
                setState(() {

                });
              }else{
                inprogress=true;
                startDownloading();
                setState(() {

                });
              }
            },
            child: Container(
              padding: EdgeInsets.all(10),margin: EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.grey[800],borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text('download this part : '+ widget.sizefile+' mb',style: TextStyle(fontSize: 12,color: Colors.white),),),)
        ],): Column(children: [
            Text((_progress*100).toStringAsFixed(2)+' %' ,style: TextStyle(fontSize: 8),),
         Expanded(child:
         Stack(children: [
           Align(alignment: Alignment.center,child: CircularPercentIndicator(
             radius: 40.0,
             lineWidth: 4.0,
             percent: _progress,
             center:  Container(),
             backgroundColor: Colors.grey[300],
             progressColor: Colors.red[400],
           ) )  ,

           Center(child:  InkWell(
             onTap: (){
               if(inprogress){
                 inprogress=false;
                 download_streem.cancel();
                 setState(() {

                 });
               }else{
                 inprogress=true;
                 startDownloading();
                 setState(() {

                 });
               }
             },
             child: Icon(Icons.stop_rounded, color: Colors.red,size: 40,),),)


         ],)
         )
        ],)


        ,)
    ],)  ;
  }
}
