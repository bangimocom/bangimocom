import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/defines.dart';
import 'package:flutter_app/home/edit_profile/fullscreen_dialog.dart';
import 'package:flutter_app/home/edit_profile/map_picker.dart';
import 'package:flutter_app/core/socket_handle.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:provider/provider.dart';

class edit_profile extends StatefulWidget {

  socket_handle  connect_to_backend;
  edit_profile({ @required this.connect_to_backend }) ;

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<edit_profile>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    name_cont.text=widget.connect_to_backend.home_list[1]['name'].toString();
    manager_name_cont.text=widget.connect_to_backend.home_list[1]['manager_name'].toString();
    address_cont.text=widget.connect_to_backend.home_list[1]['address'].toString();
    postcode_cont.text=widget.connect_to_backend.home_list[1]['post_code'].toString();
    widget.connect_to_backend.lat=widget.connect_to_backend.home_list[1]['lat'].toString();
    widget.connect_to_backend.lan=widget.connect_to_backend.home_list[1]['lan'].toString();

    super.initState();
  }
  File img_prof;
  void get_img_prof() async {
    try {
      img_prof = await FilePicker.getFile(type: FileType.image );
      // type : FileType.IMAGE ,  FileType.CUSTOM ,  FileType.ANY ,  FileType.AUDIO,  FileType.VIDEO
      // fileExtension : zip , jpg , ...

    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;

    if( img_prof != null){
 await   widget.connect_to_backend.edit_image_profile(img_prof.path, context).then((value) {
  print(value.toString());
});
 await widget.connect_to_backend.first_requests(0,20);
 await setState(() {

});
    }
  }
TextEditingController name_cont=TextEditingController();
  TextEditingController manager_name_cont=TextEditingController();
  TextEditingController address_cont=TextEditingController();
   TextEditingController postcode_cont=TextEditingController();
bool progress=false;
  @override
  Widget build(BuildContext context) {
    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);

    return  Scaffold(
        body:  Container(
          color: Colors.white,
          child:  ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                   Container(
                    height: 250.0,
                    color: Colors.white,
                    child:  Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(right: 20.0, top: 20.0),
                            child:  Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                               InkWell(onTap: (){
Navigator.pop(context);

                               },child: Icon(
                                 Icons.arrow_back_ios,
                                 color: Colors.black,
                                 size: 22.0,
                               ),)  ,
                                Padding(
                                  padding: EdgeInsets.only(right: 25.0),
                                  child:  Text('پروفایل',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                          color: Colors.black)),
                                )
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: InkWell(
                            onTap: (){
                              get_img_prof();
                            },
                            child:  Stack(fit: StackFit.loose, children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                              Container(
                                width: 140,height: 140,
                                child: ClipRRect(child:  CachedNetworkImage(
                                imageUrl:
                                connect_to_backend.home_list[1]['picture'].toString()==""?
                                "https://espindula.com.br/imagens/avatar.jpg":
                                defines().image_folder+ connect_to_backend.home_list[1]['picture'].toString(),
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Image.asset('assets/avatar.png'),
                                fit: BoxFit.fill,
                                fadeInCurve: Curves.easeIn ,
                                fadeInDuration: Duration(seconds: 2),
                                fadeOutCurve: Curves.easeOut,
                                fadeOutDuration: Duration(seconds: 2),

                              ),borderRadius: BorderRadius.all(Radius.circular(400)),),)  ,
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 90.0, right: 100.0),
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 25.0,
                                      child:  Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )),
                          ]),),
                        )
                      ],
                    ),
                  ),
                   Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  right: 25.0, left: 25.0, top: 25.0),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                   Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                       Text(
                                        'مشخصات پروفایل',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                   Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? _getEditIcon() :  Container(),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  right: 25.0, left: 25.0, top: 25.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                   Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                       Text(
                                        'نام',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  right: 25.0, left: 25.0, top: 2.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                   Flexible(
                                    child:  TextField(controller: name_cont,
                                      decoration:  InputDecoration(
                                        hintText: "نام گالری یا سالن را وارد کنید",
                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,

                                    ),
                                  ),
                                ],
                              )),

                          Padding(
                              padding: EdgeInsets.only(
                                  right: 25.0, left: 25.0, top: 25.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child:  Text(
                                        'نام مدیر',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  right: 25.0, left: 25.0, top: 2.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child:  TextField(controller: manager_name_cont,
                                        decoration: const InputDecoration(
                                            hintText: "نام مدیر را وارد کنید"),
                                        enabled: !_status,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  right: 25.0, left: 25.0, top: 25.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child:  Text(
                                        'آدرس',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  right: 25.0, left: 25.0, top: 2.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child:  TextField(controller: address_cont,
                                        decoration: const InputDecoration(
                                            hintText: "آدرس خود را وارد کنید"),
                                        enabled: !_status,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  right: 25.0, left: 25.0, top: 25.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child:  Text(
                                        'کد پستی',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  right: 25.0, left: 25.0, top: 2.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child:  TextField(controller: postcode_cont,
                                        decoration:   InputDecoration(
                                            hintText: "کد پستی فروشگاه را وارد کنید"),
                                        enabled: !_status,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  right: 25.0, left: 25.0, top: 25.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child:  Text(
                                        "مکان فروشگاه شما بر روی نقشه",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Divider(height: 10,color: Colors.transparent,),
                          Padding(
                              padding: EdgeInsets.only(
                                  right: 25.0, left: 25.0, top: 2.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                               Expanded(child: Container(height: 200,child: InkWell(
                                child: IgnorePointer(child: map_picker(have_float:  !_status? false:null,),),onTap: (){
                             ! _status?   Navigator.of(context).push(fullscreen_dialog(widget: map_picker(have_float: true,))):
                             null;
                               },
                              )
                                  ),)
                                ],
                              )),
                          !_status ? _getActionButtons() :  Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(right: 25.0, left: 25.0, top: 45.0),
      child:  Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child:progress?Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Container(width: 20,height: 20,child: CircularProgressIndicator(),)
                  ],):  RaisedButton(
                    child:  Text("ذخیره"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () async{
                    await  setState(() {
                        progress=true;
                      });
                    await    widget.connect_to_backend.edit_profile_req(address_cont.text,
                           name_cont.text, manager_name_cont.text, postcode_cont.text, 'city', 'state', context);
                    await  setState(() {
                      progress=true;
                      _status = true;
                    });
                    await widget.connect_to_backend.first_requests(0,20);

                    },
                    shape:  RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child:  RaisedButton(
                    child:  Text("انصراف"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                      });
                    },
                    shape:  RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return  GestureDetector(
      child:  CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child:  Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}