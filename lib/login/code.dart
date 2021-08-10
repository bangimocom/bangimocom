
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/home/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../defines.dart';
import 'package:http/http.dart' as http;

class code extends StatefulWidget {
  String mobile;
  code({@required this.mobile});
  @override
  State<StatefulWidget> createState() {
    return new code_page();
  }

}


int value_time=120;
bool progressenable=false;
class code_page extends State<code> {

  SharedPreferences prefs ;
  TextEditingController code_controller=new TextEditingController();
//  await prefs.setString('mobile', phone);
  Future find_from_server(val, BuildContext context) async {
    var client =  http.Client();
    await     setState(() {
      progressenable=true;
    });
    client.post(Uri.encodeFull(defines().request_url),  body: {
      "command": "trasfer_code",
      "mobile": widget.mobile,
      "code": val,
    }).then((response) async{
      client.close();
      if (this.mounted && response.statusCode == 200) {
        print(response.body.toString());
        if(json.decode(utf8.decode(response.bodyBytes))['code']=="true"){
          print("login success: "+ json.decode(utf8.decode(response.bodyBytes))['token'].toString());
//        int counter = (prefs.getInt('counter') ?? 0) + 1;
//        print('Pressed $counter times.');
          await    _timer.cancel();
          await      prefs.setString("token",  json.decode(utf8.decode(response.bodyBytes))['token']);
          await      prefs.setString("token",  json.decode(utf8.decode(response.bodyBytes))['token']);
          await    Navigator.pop(context);
          await     setState(() {
            progressenable=false;
          });
          await    Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (contextme) => MaterialApp(

              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],  theme: ThemeData(fontFamily: 'meysam',
                primarySwatch: Colors.blue,accentColor: Colors.lightBlueAccent,primaryColor: Colors.lightBlueAccent
            ),
              supportedLocales: [
                Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
              ],
              locale: Locale("fa", "IR"),
              home: home(),)),
                (Route<dynamic> route) => false,
          );
        }else{
          print("login breaked");
          show_snackbar(
              'invalid varification code !',
              context);
        }
        setState(() {
          progressenable=false;
        });
      }
    }).catchError((onError) {
      client.close();
      print("Error: $onError");
    });

  }


  Timer _timer;
  int _start = 120;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
            _start=120;
            Navigator.pop(context);
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    progressenable=false;
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    init_shared();
  }
  String my_phone;
  void init_shared() async {
    prefs = await SharedPreferences.getInstance();
    my_phone=prefs.getString("mobile");
  }
  GlobalKey<ScaffoldState> _scaffoldKey =   GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {



    return Material( child:Scaffold(key: _scaffoldKey,
        body: Container(
          child:SingleChildScrollView(child:Padding(child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("لطفا کد sms شده به گوشی خود را وارد کنید ",textDirection: TextDirection.rtl,),
              SizedBox(width: 100,height: 50,child:
              TextFormField(controller: code_controller,
                style: TextStyle(fontSize: 26),keyboardType: TextInputType.number,) ,)
              ,Divider(height: 30,)
              , MaterialButton(
                child:  progressenable ==true ? CircularProgressIndicator() : Text("تایید")
                ,
                onPressed: (){
                progressenable ==true ? null :  find_from_server(code_controller.text, context);

              },)
              ,Divider(height: 70,)
              ,
              CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 10.0,
                percent: (_start/120),
                header:   Text(""),
                center:
                Text(_start.toString(),textAlign: TextAlign.center,),
                backgroundColor: Colors.teal,
                progressColor: Colors.white,
              ),



            ],
          ),padding: EdgeInsets.all(50),)
            ,)


        )
    ),);
  }
  void show_snackbar(String text, BuildContext context) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(Icons.thumb_down),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              text,
            ),
          ),
        ],
      ),
    ));
  }
}