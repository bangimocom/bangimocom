import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/core/socket_handle.dart';
import 'package:flutter_app/pages/AboutUs.dart';
import 'package:flutter_app/pages/website/Enamad.dart';
import 'package:flutter_app/pages/website/Website.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'folders/Folders.dart';
import 'Profile.dart';
import 'package:animated_icon_button/animated_icon_button.dart';

import 'login_page.dart';

class homepage extends StatefulWidget {
  bool islogin;
  homepage({key,@required this.islogin}) : super(key: key);

  @override
  _homepage createState() => _homepage();
}



class _homepage extends State<homepage>{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => socket_handle()),
      ],
      child: Consumer<socket_handle>(
        builder: (context, counter, _) {

          final connect_to_backend = Provider.of<socket_handle>(context, listen: true);
          return mainpage(connect_to_backend: connect_to_backend,islogin: widget.islogin,);
        },
      ),
    );
  }
}

class mainpage extends StatefulWidget{
  bool islogin;
  socket_handle connect_to_backend;
  mainpage({@required this.connect_to_backend,@required this.islogin});
  @override
  _mainpageState createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> with SingleTickerProviderStateMixin  {
  TabController tabController;
  var name = "meysam";
  @override
  void initState() {
    print('home');
    tabController = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => socket_handle()),
      ],
      child: Consumer<socket_handle>(
        builder: (context, counter, _) {
          final connect_to_backend = Provider.of<socket_handle>(context, listen: true);
          connect_to_backend.offstage_context=context;
          return home(connect_to_backend:connect_to_backend,islogin: widget.islogin,);
        },
      ),
    );
  }
}

class home extends StatefulWidget {
  bool islogin;
  socket_handle connect_to_backend;
  home({@required this.connect_to_backend,@required this.islogin});
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {



  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  @override
  void initState() {

    getfirsrequest();
    super.initState();
  }
  void getfirsrequest()async{
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    if(widget.islogin==true){
      await  widget.connect_to_backend.get_offline_data( );
      await  widget.connect_to_backend.get_home( );
      await setState(() {

      });
    }
  }
  var bottomNavStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  @override
  Widget build(BuildContext context) {
    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);
    final Orientation orientation = MediaQuery.of(context).orientation;
    connect_to_backend.isLandscape = orientation == Orientation.landscape;
    print('isLandscape : '+connect_to_backend.isLandscape .toString());
    if(connect_to_backend.isLandscape){
      SystemChrome.setEnabledSystemUIOverlays([]);
    }else{
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }
    return   WillPopScope(
        onWillPop: () async {
      final isFirstRouteInCurrentTab = !await _navigatorKeys[widget.connect_to_backend.selectedIndex].currentState.maybePop();
      return isFirstRouteInCurrentTab;
    },child :Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              flex: 9,
              child:
             IndexedStack(children: [

                _buildOffstageNavigator(0,connect_to_backend,widget.islogin),
                _buildOffstageNavigator(1,connect_to_backend,widget.islogin),
                _buildOffstageNavigator(2,connect_to_backend,widget.islogin),
                _buildOffstageNavigator(3,connect_to_backend,widget.islogin),
               _buildOffstageNavigator(4,connect_to_backend,widget.islogin),
              ],
                index:connect_to_backend.selectedIndex,
              )

          ),
          connect_to_backend.isLandscape ?Container():   Container(
            height: 60,
            decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)), boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(
                      0.2,
                    ),
                    spreadRadius: 2,
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ]),
            child: Row(children :  [
              Expanded(child:InkWell(
                onTap: (){
                  setState(() {
                    connect_to_backend.selectedIndex=0;
                  });
                  connect_to_backend.change_data();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // connect_to_backend.selectedIndex == 0?
                        Image.asset('assets/home.png',color: Colors.grey[500],width: 25,height: 25,)
                        // :  Image.asset('assets/user.png',color: Colors.grey[500],width: 37,height: 37,)

                      ],)
                  ],),)  ) ,
              Expanded(child:InkWell(
                onTap: (){
                  setState(() {
                    connect_to_backend.selectedIndex=1;
                  });
                  connect_to_backend.change_data();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/folder.png', width: 25,height: 25,)

                      ],)
                  ],),)  ) ,
              Expanded(child:InkWell(
                onTap: () async{
                  setState(() {
                    connect_to_backend.selectedIndex=2;
                  });
                  connect_to_backend.change_data();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // connect_to_backend.selectedIndex == 2?
                        Image.asset('assets/info.png' ,width: 45,height: 45,)
                        // : Image.asset('assets/info.png',color: Colors.grey[500],width: 37,height: 37,)

                      ],)
                  ],),)  ) ,
              Expanded(child:InkWell(
                onTap: () async{
                  String url =widget.connect_to_backend.aboutus['whatsapp_link'].toString();
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/whatsapp.png' ,width: 25,height: 25,)

                      ],)
                  ],),)  ) ,
              Expanded(child:InkWell(
                onTap: (){
                  setState(() {
                    connect_to_backend.selectedIndex=4;
                  });
                  connect_to_backend.change_data();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/user.png',  width: 25,height: 32,)

                      ],)
                  ],),)  ) ,
            ],
            ),
          )
        ],
      ) ,
    ));
  }

  Widget _buildOffstageNavigator(int index,socket_handle connect_to_backend,bool islogin) {

    // print('sssssss :'+ connect_to_backend.token.toString());
    return Offstage(
      offstage: false,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) {
              return [
                Website(connect_to_backend:connect_to_backend,url: 'https://englishturbo.com/', isvideoDetails: false,),
                islogin==true ? Folders(connect_to_backend:connect_to_backend,category: 'order',
                  items:connect_to_backend.orderinfo_list, title_appbar: '',)
                    : LoginPage(connect_to_backend: widget.connect_to_backend,),
                 Enamad(connect_to_backend:connect_to_backend,),
                AboutUs(connect_to_backend:connect_to_backend,),
                islogin==true ?   Profile(connect_to_backend:connect_to_backend,):
                LoginPage(connect_to_backend: widget.connect_to_backend)
              ,
              ].elementAt(index);
            },
          );
        },
      ),
    );
  }
}
