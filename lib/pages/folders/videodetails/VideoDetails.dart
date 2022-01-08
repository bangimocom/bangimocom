import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/BackButton.dart';
import 'package:flutter_app/core/database_helper.dart';
import 'package:flutter_app/core/socket_handle.dart';
import 'package:flutter_app/defines.dart';
import 'package:flutter_app/pages/folders/videodetails/hyperText.dart';
import 'package:flutter_app/pages/website/Website.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_zip_archive/flutter_zip_archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'DownloadVideo.dart';
import 'package:flutter_html/flutter_html.dart';


import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:encrypt/encrypt.dart' as en;
import 'package:chewie/chewie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:video_player/video_player.dart';
class VideoDetails extends StatefulWidget {
var item;
  socket_handle connect_to_backend;
  VideoDetails({@required this.connect_to_backend,@required this.item});

  @override
  _VideoDetailsState createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {


  FlutterWebviewPlugin  flutterWebviewPlugin = new FlutterWebviewPlugin();

  Database db;
  void init_db() async{
    db = await DatabaseHelper.instance.database;

  }
  bool error=false;
  @override
  void initState() {
    // print('ooooo:'+widget.item.toString());
    first_commnd();

        flutterWebviewPlugin.onHttpError.listen((WebViewHttpError e) {
          print('errrr :'+e.toString());
          setState(() {
            error=true;
          });
        });
  }
  void first_commnd()async{

    await  init_db();
    await print ('itemmmmm :'+widget.item['post_content'].toString());
    await  get_video(widget.item['ID'].toString());
  await     initialvideo();
  }
  var server_result;
  void get_video(String ID ) async{

    print('get_video');
    var client =  http.Client();
    await  client.post(Uri.parse(defines().request_url2),  body: {
      "command": "get_video",
      "ID": ID,
    } ).then((response) async{
      client.close();
      await  print('server_resul  :'+ widget.item['ID'].toString());
      if (  response.statusCode == 200) {

        try{
          server_result= await json.decode(utf8.decode(response.bodyBytes));
          print('server_result :'+server_result.toString());
          items= await  server_result['items'];
          await set_paths(server_result['path'].toString());
        }catch(e){

        }

        await  print('222222222 :'+server_result.toString());
        await setState(() {
});
      }

    }).catchError((onError) {
      client.close();
      print("Errorvideodetil: $onError");
    });
  }


String path360;
  String path720;
  var chewieController ;
  VideoPlayerController videoPlayerController;
  void set_paths(String path) async{

    List pp=  await path.split(',');
    path360= defines().video_folder+ await pp[0].toString();
    path720= defines().video_folder+ await pp[1].toString();
    // print('path360 : '+path360);
    // print('path720 : '+path720);

  }
  ProgressDialog pr;
  String sizefile='';
  void check_if_existondb(String id)async{
    List<Map>  result= await db.rawQuery("SELECT * FROM  videos WHERE id='"+id+"'");
    if( await result.length<1){
     await set_paths(server_result['path'].toString());
     http.Response r = await http.head(Uri.parse(path720));
     sizefile= await (double.parse(r.headers["content-length"].toString())/1000000).toInt().toString();
     await  print('contentlength :'+r.headers["content-length"].toString()) ;
     //  videoPlayerController = await  VideoPlayerController.network(path720);
     // await videoPlayerController.initialize();
      print('eeeeee :nooooo');
    }else{
       // print('eeeeee :yessssss : '+result[0]['path'].toString());

        pr = ProgressDialog(context);
      pr.style(
          message: '... در حال بارگزاری ',);
      pr.show();

      await decryp(result[0]['path'].toString()).then((value) async{
        videoPlayerController = await VideoPlayerController.file(File(value));
        await videoPlayerController.initialize();
        proccess_complete_file=  await File(value);
        setState(() {
          inprogress=true;
          existvideo=true;
        });
      });
        try{
          chewieController = await  ChewieController(
            videoPlayerController: videoPlayerController,allowPlaybackSpeedChanging: false,
            autoPlay: false,overlay: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 100,child: hyperText(mobile: widget.connect_to_backend.userinfo['user_login'].toString(),) ,)

            ],),
            looping: false,
          );

        }catch(e){}
      pr.hide();

    }
  }

File proccess_complete_file =null;

  Future<String> decryp(String path) async{
    // Directory _cacheDir = await getTemporaryDirectory();
    var _map=await FlutterZipArchive.unzip(path,path+'0'  ,defines().password);
    // print("_cacheDir:"+_cacheDir.toString());
    print("_map:"+_map.toString());
    return await  path+'0/'+_map['files'].toString() ;
  }

  void change_qual(String q) async{
      await  videoPlayerController.pause();
      await  setState(() {

      });
      chewieController= await null;
       videoPlayerController=  await null;
if(q=='360p'){

  videoPlayerController = await  VideoPlayerController.network(
      path360);

  qual='360p';
}else{
  videoPlayerController = await  VideoPlayerController.network(
      path720);

  qual='720p';
}
    await videoPlayerController.initialize();
     chewieController = await  ChewieController(
       videoPlayerController: videoPlayerController,allowPlaybackSpeedChanging: false,
       autoPlay: false,
       looping: false,
     );
    await  setState(() {
qual=q;
    });
    print('qual : '+qual);
  }



  bool show_reso=true;
  Function falseresolotion() {
      // check_if_existondb(server_result['ID'].toString());
      // chewieController =    ChewieController(
      //   videoPlayerController: videoPlayerController,allowPlaybackSpeedChanging: false,
      //   autoPlay: false,overlay: hyperText(),
      //   looping: false,
      // );
      //     setState(() {
      //   inprogress=true;
      //   show_reso=false;
      // });
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (contextme) =>
    //       VideoDetails(connect_to_backend: widget.connect_to_backend,
    //           item: widget.item)),
    //       (Route<dynamic> route) => false,
    // );
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (contextme) => VideoDetails(connect_to_backend: widget.connect_to_backend,
    //       item: widget.item)),
    //       (Route<dynamic> route) => false,
    // );
    fff();

  }
  void fff() async{
  await  Navigator
        .pop(context);
  await     Navigator
        .of(context)
        .push(MaterialPageRoute(builder: (contextme) => VideoDetails(connect_to_backend: widget.connect_to_backend,
        item: widget.item)));
  }

bool existvideo=false;
  void initialvideo() async{
try{


  await check_if_existondb(server_result['ID'].toString());
}catch(e){}


    await   setState(() {
inprogress=true;
      });

  }
  bool inprogress=false;

  @override
  void dispose() {
    try{

      videoPlayerController.dispose();

    }catch(e){}
   if(proccess_complete_file!=null){
     proccess_complete_file.delete();
   }
   flutterWebviewPlugin.dispose();
    super.dispose();
  }

  String qual='720p';
  List items=[];

  @override
  Widget build(BuildContext context) {

    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);
    return
      Column(children: [

        connect_to_backend.isLandscape ?Container():    Container(
          height: 85,
          alignment: Alignment.topCenter,
          width: double.infinity,
          child:
          Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                connect_to_backend.isLandscape ?Container():     Divider(height: 40,color: Colors.transparent,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Expanded(child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('      '),
                        Back__Button(cc: context,)
                      ],),),
                    Image.asset('assets/asatir.png',height: 30,)
                  ,
                    Expanded(child: Container())
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
        Expanded(child:
            Column(children: [

              connect_to_backend.isLandscape ?Container():
              Container(child: Column(children: [
        Container(height: 20,),
        Text(
          widget.item['post_title'].toString(),overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(height: 20,),
      ],),)  ,
              Expanded(child:  Scaffold(body: server_result==null ?
              Column(children: [
                Expanded(child:  webviewplayer(context,connect_to_backend))
                ,
                connect_to_backend.isLandscape ?Container():    botoombar(context)
              ],) :
              Column(children: [
                Expanded(child: inprogress && chewieController!=null ?

                Chewie(
                  controller: chewieController,
                ) :
                Column(children: [
                  Expanded(child: webviewplayer(context,connect_to_backend),) ,

                  connect_to_backend.isLandscape ?Container():     botoombar(context)

                ],)
                )
              ],)  ,))
        ],)


        )

      ],)
      ;
  }
Widget botoombar(context){
    return    server_result==null ?
    // Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children:[Container(width: 20,height: 20,child: CircularProgressIndicator(),)] ,)
        Container()
        :
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        existvideo?Container():
        DownloadVideo(connect_to_backend: widget.connect_to_backend,
          current_path_video:  path720,item: widget.item,db: db,
          falseresolotion: falseresolotion, sizefile: sizefile,),
        existvideo || !show_reso?Container(): InkWell(
          onTap: (){

            showDialog(context: context,builder: (context){
              return  AlertDialog(contentPadding: EdgeInsets.all(10),
                  content: Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10,left: 10 , ),
                            child: InkWell(onTap: (){
                              if(qual=='720p'){
                                change_qual('360p');
                                Navigator.pop(context);
                              }

                            },child: Card(elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(color: qual=='360p'? Colors.green[200]:Colors.white,
                                padding: EdgeInsets.all(0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Container(
                                            margin: EdgeInsets.only(right: 20),
                                            child: Text('quality 360',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            )),
                          ),

                        ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10,left: 10 , ),
                            child: InkWell(onTap: (){
                              if(qual=='360p'){
                                change_qual('720p');

                                Navigator.pop(context);
                              }

                            },child: Card(elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(color: qual=='720p'? Colors.green[200]:Colors.white,
                                padding: EdgeInsets.all(0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Container(
                                            margin: EdgeInsets.only(right: 20),
                                            child: Text('quality 720',textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            )),
                          ),

                        ],),
                    ],
                  )
              );
            });
          },
          child: Container( height: 40,
            padding: EdgeInsets.all(10),margin: EdgeInsets.all(0),
            decoration: BoxDecoration(color:Colors.grey[800], borderRadius: BorderRadius.circular(10),),

            child: Text('select quality',style: TextStyle(color: Colors.white, fontSize: 12 ),),),)

      ],);
}


  Widget webviewplayer(context,socket_handle connect_to_bckend){
    return Stack(children: [
      Website(connect_to_backend: widget.connect_to_backend,
        url: defines.domain2+'/player.php?post_content='+widget.item['post_content'].toString()+'&mobile='
            +widget.connect_to_backend.userinfo['user_login'].toString(),
        isvideoDetails:  true,),
    // Container(height:
    //
    // !connect_to_bckend.isLandscape? 200: MediaQuery.of(context).size.height
    //   ,child: chewieController!=null?Container(): Column(
    //     mainAxisAlignment: MainAxisAlignment.center,children: [
    //     Container(height: 100,child: hyperText(mobile: widget.connect_to_backend.userinfo['user_login'].toString(),) ,)
    //
    // ],) ,)
    ],)
       ;
  }
}
