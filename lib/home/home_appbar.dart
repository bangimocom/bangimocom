import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/home/search/search.dart';
import 'package:flutter_app/core/socket_handle.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:ripple_effect/ripple_effect.dart';
import 'package:smart_select/smart_select.dart';

import 'home.dart';

class home_appbar extends StatefulWidget {

  var pageKey = RipplePage.createGlobalKey();
  var effectKey = RippleEffect.createGlobalKey();
  GlobalKey<ScaffoldState> drawerKey;
  socket_handle  connect_to_backend;
  home_appbar({@required this.drawerKey,@required this.pageKey,@required this.effectKey
    ,@required this.connect_to_backend,});
  @override
  State<StatefulWidget> createState() {
    return new home_appbar_page();
  }

}

class home_appbar_page extends State<home_appbar> {
String value='0';
  @override
  void initState() {
  value=widget.connect_to_backend.home_list[1]['name'].toString();
  setState(() {

  });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);


    return  Row(children: [
          InkWell(child:Container(child:
          Image.asset('assets/menu.png',color: Colors.white,height: 25,)
            ,width: 25,height: 25,) ,
            onTap: (){
              widget.drawerKey.currentState.openDrawer();
            },) ,
     Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
       Container(
         width: 200,
         child: SmartSelect<String>.single(
             title: '',
             value: value,placeholder: 'گالری ها',
             options: connect_to_backend.options,
             onChange: (val) {
               value = val;
               print(val);
               connect_to_backend.my_phone=val;
               connect_to_backend.home_request(0,20);

              connect_to_backend.change_data();
             }
         ), )
     ],) ,
          Expanded(child: Container(),),
      RippleEffect(
        pageKey: widget.pageKey,
        effectKey:  widget.effectKey,
        color: Colors.white,
        child: InkWell(child:Container(child:
    Image.asset('assets/search.png',color: Colors.white,height: 25,)
    ,width: 25,height: 25,),
    onTap: (){
      RippleEffect.start( widget.effectKey, () => Navigator.of(context).push(
        FadeRouteBuilder(
          page: search(connect_to_backend: connect_to_backend,),
        ),
      ),);
    },) ,
      )   ,
        ],)
     ;
  }

  @override
  void dispose() {
super.dispose();
  }
void pre_start() async{

 await  Future.delayed( Duration(milliseconds: 3000), () {
    setState(() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (contextme) => MaterialApp(

          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
          ],
          locale: Locale("fa", "IR"),
          home: home(),)),
            (Route<dynamic> route) => false,
      );
    });
  });
}

}
