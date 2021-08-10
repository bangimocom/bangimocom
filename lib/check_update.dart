import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'defines.dart';

class check_update {
 static var link_download;
  Future get_state_update(BuildContext context) async {
    try {
      Dio dio = new Dio();
      FormData formData =
          FormData.fromMap({"command": "update", "version": defines().version});
      Response response = await dio.post(defines().request_url, data: formData);

//      var info_prof = json.decode(response.data)[0];
//      print(info_prof['mobile']);

      if (response.data.toString() == "updated") {
        print(response.data.toString());
      } else {
         link_download = json.decode(response.data)['link_download'];
        print(link_download);
        showDialog(context: context, builder: (BuildContext context) => dialog);
      }
    } catch (e) {
      print(e.toString());
    }
  }

 static launchURL(String link_download) async {
    if (await canLaunch(link_download)) {
      await launch(link_download);
    } else {
      throw 'Could not launch $link_download';
    }
  }

  AlertDialog dialog = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        "لطفا برای اجرای بهتر اپلیکیشن را آپدیت کنید ",
        style: TextStyle(fontSize: 20.0),
      ),MaterialButton(child:Text("آپدیت شود",style: TextStyle(color: Colors.purple,fontSize: 20),),onPressed: (){
        launchURL(link_download);
      },)
    ],
  ));
}
