import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/UpdatePage.dart';
import 'package:flutter_app/defines.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/splashscreen.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';
import 'database_helper.dart';

class socket_handle with ChangeNotifier {

  void change_data(){
    notifyListeners();
  }
  TabController tab_controller;
BuildContext main_context;
BuildContext offstage_context;



  String my_phone;
  int selectedIndex = 1;
  SharedPreferences prefs;
  String token =null ;
  GlobalKey<ScaffoldState> scaff = GlobalKey<ScaffoldState>();



  Map<String,String> headers  ;

  var  userinfo  ;
  List  orderinfo_list ;
  var  profile ;

  Database db;
  void get_offline_data( ) async{
    db = await DatabaseHelper.instance.database;
    List  result= await db.rawQuery("SELECT * FROM reqs WHERE type='home'");
    if(await result.length>0){
      // await   orderinfo_list.addAll(json.decode(result ));
      // categories_list=home_list[0];
      // profile=home_list[2];
      // await   log('homeeee :'+result.toString());
      await   tahlil_res( json.decode(result[0]['content'].toString())  );
    }
    await   change_data();
  }
  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
  void get_home( ) async{

    prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token');
      // print('token='+token);
    headers =  await {'Accept':'application/json, text/plain, */*',
      defines.pre=="https://englishturbo.com"?
      'Authorization':'authorization' : token.toString() };
    // await print('get_home : '+ headers.toString());
    var client =  http.Client();
    await  client.get(Uri.parse(defines().home_request),
        headers: headers).then((response) async{
      await   client.close();
       // await  log('status code ='+ response.statusCode.toString()+' | '+utf8.decode(response.bodyBytes));
      if (  response.statusCode == 200) {
        var res0= await  utf8.decode(response.bodyBytes) ;
        await log('rrrrrrrr: '+res0);
        var res= await json.decode(res0);
        await  tahlil_res(res);
        // await  home_list.addAll(json.decode(res)['orderinfo']);
        // categories_list=home_list[0];
        // videos_list=home_list[1];
        // profile=home_list[2];
        // print('home :'+orderinfo_list.length.toString());
        // await log(res0.toString());
        // await   printWrapped(orderinfo_list[0].toString());
        await db.rawQuery("delete from reqs ");
        Map<String, dynamic> row = {
          DatabaseHelper.columntype : 'home',
          DatabaseHelper.columncontent  : res0
        };
        final id =  await db.insert('reqs', row);
        // print('inserted row id: $id');
        await   get_offline_data( );
        await change_data();

      }
      else  if (  response.statusCode == 404) {
        await  logout();
        token=null;
        print('eeeeeeeee :'+  token.toString());
        change_data();
      }
    }).catchError((onError) {
      client.close();
      print("Error: $onError");
    });
  }
void tahlil_res(res) async{
  orderinfo_list= await  res['orderinfo'] ;
  userinfo = await res['userinfo'];
}
    bool isLandscape=false;
  var  aboutus =json.decode('{ '
  '"name" : "اپلیکیشن توربو زبان",'
  '"dsc" : "توربو",'
  '"description" : "<p>English app<br /> Package</p>",'
  '"telegram" : "https://t.me/froshghah_onlin",'
  '"website" : "https://iranich.com/",'
  '"instagram" : "https://www.instagram.com/camila_cabello/",'
  '"address" : ""  '
'}'
) ;







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
// Future<String> get

  void logout() async {
    await  prefs.remove('token');
    // await db.rawQuery("delete from reqs ");
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path =await join(documentsDirectory.path, DatabaseHelper.databaseName);
    await File(path).delete()
        .then((value) async{
      await   Navigator.pushAndRemoveUntil(
        offstage_context,
        MaterialPageRoute(builder: (contextme) => MaterialApp(

          home: splash(),)),
            (Route<dynamic> route) => false,
      );
    });


  }
  void deletedb() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path =await join(documentsDirectory.path, DatabaseHelper.databaseName);
  try{
    await File(path).delete()
      .then((value) async{

  });
  }catch(e){}
  }



}