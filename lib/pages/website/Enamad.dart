import 'dart:async';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/socket_handle.dart';


import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Enamad extends StatefulWidget {
  socket_handle connect_to_backend;
  Enamad({@required this.connect_to_backend, });
  @override
  _EnamadState createState() => _EnamadState();
}

class _EnamadState extends State<Enamad> {

  WebViewController _controller;

  @override
  void initState() {
    super.initState();
  // print('')
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
  int j=0;
  @override
  Widget build(BuildContext context) {
    final connect_to_backend = Provider.of<socket_handle>(context, listen: true);
  return connect_to_backend.selectedIndex==2   ? Scaffold(body:
  Column(children: [
    Container(height: 40,),

    Expanded(child: Stack(children: [

      Scaffold(body:  WebView(
        initialUrl: 'https://englishturbo.com/',
        javascriptMode: JavascriptMode.unrestricted,

        onWebViewCreated: (WebViewController webViewController) {
          // Get reference to WebView controller to access it globally
          _controller = webViewController;
        },onPageStarted: (String url){
        print('url onPageStarted : ' + url);
if(url=='https://trustseal.enamad.ir/?id=215823&Code=TS5FETZGZDXpTjJRU1vz'){

}else{
  setState(() {
    inprogress=true;
  });
}

      },
        onPageFinished: (String url) {
          print('url changed : ' + url);

          setState(() {
            j++;

          });
            _controller.evaluateJavascript('if(location.hostname == "englishturbo.com"){'
                '  window.location.href = "https://trustseal.enamad.ir/?id=215823&Code=TS5FETZGZDXpTjJRU1vz";}');
          if(url=='https://trustseal.enamad.ir/?id=215823&Code=TS5FETZGZDXpTjJRU1vz'){
            setState(() {
              inprogress=false;
            });
          }

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
      inprogress || j==0 ? Scaffold(body: Center(child:
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
