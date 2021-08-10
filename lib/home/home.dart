
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/home/cart/cart.dart';
import 'package:flutter_app/home/home_appbar.dart';
import 'package:flutter_app/home/product_list.dart';
import 'package:flutter_app/core/socket_handle.dart';
import 'package:provider/provider.dart';
import 'package:ripple_effect/ripple_effect.dart';

import 'navigationdrawer/drawer.dart';



class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => socket_handle()),
      ],
      child: Consumer<socket_handle>(
        builder: (context, counter, _) {

          final connect_to_backend = Provider.of<socket_handle>(context, listen: true);
          return MyHomePage(title: 'parvaneh',connect_to_backend: connect_to_backend,)
          ;
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  socket_handle  connect_to_backend;
  MyHomePage({Key key, this.title,@required this.connect_to_backend }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() =>  _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();


  @override
  void initState() {

    getfirst_requests();
    super.initState();
  }

  void getfirst_requests() async{
 await   widget.connect_to_backend.first_requests(0,20);
 await   setState(() {

   widget.connect_to_backend.level=   widget.connect_to_backend.home_list[1]['level'].toString();
  });
  }

  final pageKey = RipplePage.createGlobalKey();
  final effectKey = RippleEffect.createGlobalKey();
  @override
  Widget build(BuildContext context) {
    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);
    GlobalKey<NavigatorState>  navigatorKey= GlobalKey<NavigatorState>();
connect_to_backend.main_context=context;
    return WillPopScope(
      onWillPop: ()async {
        final isFirstRouteInCurrentTab = !await navigatorKey.currentState.maybePop();
        print(isFirstRouteInCurrentTab.toString());
        if (isFirstRouteInCurrentTab) {
          return true;

        }
      },
      child:  Offstage(
      offstage: false,
      child: Navigator(
        key:  navigatorKey,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) {
              return  RipplePage(
                  pageKey: pageKey,
                  child: connect_to_backend.home_list.length<1?
                Scaffold(
                  backgroundColor: Colors.white,body:  Center(child: Container(width: 30,height: 30,child:
                CircularProgressIndicator(backgroundColor: Colors.black,)
                  ,),),)  :  Scaffold(
                    key: _drawerKey,
                    appBar:
                 AppBar(title: home_appbar( effectKey: effectKey,pageKey: pageKey,drawerKey: _drawerKey,connect_to_backend: connect_to_backend,),
                 backgroundColor:connect_to_backend.home_list[1]['role'].toString()=='visitor'? Colors.white10:
                 Colors.transparent
                   ,automaticallyImplyLeading: false,elevation: 0,
                 ) ,
                  body: Stack(
                      children: <Widget>[
                        product_list( drawerKey: _drawerKey, connect_to_backend: connect_to_backend,),

                        Transform.translate(
                          offset: Offset(0.0, -56.0),
                          child:  Container(
                            child:  ClipPath(
                              clipper:  MyClipper(context: context),
                              child:  Stack(
                                children: [
                                  Image.network("https://picsum.photos/800/400?random",
                                    fit: BoxFit.cover,colorBlendMode: BlendMode.darken
                                    ,
                                  ),
                                  Opacity(
                                    opacity: 0.2,
                                    child:  Container(color: COLORS[0]),
                                  ),
                                  Transform.translate(
                                    offset: Offset(0.0, 50.0),
                                    child:  ListTile(
                                      leading:  CircleAvatar(
                                        child:  Container(
                                          decoration:  BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.transparent,
                                            image:  DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage('assets/logo.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      title:  Text(
                                        connect_to_backend.home_list[2]['name'].toString(),
                                        style:  TextStyle(
                                            color: Colors.white,
                                            fontSize: 24.0,
                                            letterSpacing: 2.0),
                                      ),
                                      subtitle:  Text(
                                        connect_to_backend.home_list[2]['3word'].toString(),
                                        style:  TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            letterSpacing: 2.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),floatingActionButton:   FloatingActionButton(onPressed: (){

              Navigator
                  .of(context)
                  .push(MaterialPageRoute(builder: (_) => cart(connect_to_backend: connect_to_backend,)));
              },
                backgroundColor: Colors.white,child:Center(child:
              Image.asset('assets/cart.png',width: 30,color:Colors.black87,)  ,) ,),drawer: drawer(),
                  )
   );
            },
          );
        },
      ),
    ) ,);
  }
}

class MyClipper extends CustomClipper<Path> {
  BuildContext context;
  MyClipper({@required this.context});
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height / (MediaQuery.of(context).size.width/108));
    p.lineTo(0.0, size.height / (MediaQuery.of(context).size.width/87));
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

