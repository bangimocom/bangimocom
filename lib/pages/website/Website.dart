import 'dart:async';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/socket_handle.dart';


import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Website extends StatefulWidget {
  socket_handle connect_to_backend;
  String url;
  bool isvideoDetails;
  Website({@required this.connect_to_backend,@required this.url,@required this.isvideoDetails});
  @override
  _WebsiteState createState() => _WebsiteState();
}

class _WebsiteState extends State<Website> {

  WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    check_internet();
  }

  @override
  void dispose() {
    super.dispose();
  }

void check_internet() async{
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
    }
  } on SocketException catch (_) {
    print('not connected');

  }
}
  bool inprogress=true;
  bool error=false;
  int i=0;
  @override
  Widget build(BuildContext context) {
    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);
  return connect_to_backend.selectedIndex==0 || widget.isvideoDetails==true ? Scaffold(body:
  Column(children: [
    widget.isvideoDetails==true ?Container() : Container(height: 40,),

    Expanded(child: Stack(children: [

      Scaffold(body:  WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          // Get reference to WebView controller to access it globally
          _controller = webViewController;
        },
        onPageFinished: (String url) {
          print('url changed : ' + url);
          setState(() {
            inprogress=false;
          });
          _controller.evaluateJavascript("document.getElementsByClassName('engt-toolbar engt-toolbar-label-show')[0].style.display = 'none';");

          // Timer.periodic(
          //     Duration(seconds: 1),
          //         (Timer timer){
          //              _controller.evaluateJavascript("document.getElementsByClassName('engt-toolbar engt-toolbar-label-show')[0].style.display = 'none';");
          //
          //         }
          // );
        },onWebResourceError: (e){
          print('nointernet');
          setState(() {
            error=true;
          });

      },
      )),
      inprogress? Scaffold(body: Center(child:
      Container(height: 20,width: 20,child: CircularProgressIndicator(color: Colors.blue,) ,),)
        ,):Container(),
      error ?Scaffold(body:Center(child: MaterialButton(child: Text('check internet and try again') ,onPressed: () {

        _controller.reload().then((value) {
          inprogress=true;
          error=false;
          setState(() {
          });
        });
      },),) ,)  : Container(),
    ],) )
  ],),):Container();
  }
}
