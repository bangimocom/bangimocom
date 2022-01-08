import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/UpdatePage.dart';
import 'package:flutter_app/core/socket_handle.dart';
import 'package:flutter_app/defines.dart';
import 'package:flutter_app/pages/ForgetPassword.dart';
import 'package:flutter_app/pages/splashscreen.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'HomePage.dart';
import 'SiteShow.dart';
class LoginPage extends StatefulWidget {
  socket_handle connect_to_backend;
  LoginPage({@required this.connect_to_backend});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  void login_user( String mobile,String password,) async{
    print('login_user');
    await setState(() {

      inprogress=true;
    });
    var client =  http.Client();
    await  client.post(Uri.parse(defines().login_request),  body: {
      "username" : mobile
      ,"password": password,
      "device_id":deviceId
    }).then((response) async{
      client.close();
      if (  response.statusCode == 200) {
        String res= utf8.decode(response.bodyBytes) ;
        print('resss: '+res);
        token = await prefs.setString('token',res);
        await  Navigator.pushReplacement(
            widget.connect_to_backend.offstage_context, MaterialPageRoute(builder: (context) =>  splash()  ));
        // await   widget.connect_to_backend.change_data();

    }else{
      String message=  json.decode(utf8.decode(response.bodyBytes))['message'];
print('fdgdfg: '+utf8.decode(response.bodyBytes));
        showInSnackBar(message);
      }


    }).catchError((onError) {
       showInSnackBar('No connection Internet');
      client.close();
      print("Error: $onError");
    });
    try{

      await setState(() {

        inprogress=false;
      });

    }catch(e){}
  }

  void get_rules(  ) async{
    print('get_rules');
    await setState(() {

      inprogress=true;
    });
    var client =  http.Client();
    await  client.get(Uri.parse(defines().rules_request) ).then((response) async{
      client.close();
      if (  response.statusCode == 200) {
        String res= utf8.decode(response.bodyBytes) ;
        // print('resrules: '+res);
        widget.connect_to_backend.aboutus = await json.decode(res) ;

        if(int.parse( widget.connect_to_backend.aboutus['version'].toString() ) > int.parse( defines().version)){
          if(widget.connect_to_backend.aboutus['update_important'].toString() =='1'){

            Navigator.pushAndRemoveUntil(
              widget.connect_to_backend.offstage_context,
              MaterialPageRoute(builder: (contextme) => UpdatePage(app_info:widget.connect_to_backend.aboutus ,)),
                  (Route<dynamic> route) => false,
            );
          }else{
            Navigator
                .of( widget.connect_to_backend.offstage_context)
                .push(MaterialPageRoute(builder: (_) =>  UpdatePage(app_info:widget.connect_to_backend.aboutus )));
          }

        }


      }else{
        print('fdgdfg: '+utf8.decode(response.bodyBytes));
        // showInSnackBar('پوزرنیم یا پسورد اشتباه است ');
      }


    }).catchError((onError) {
      client.close();
      print("Error: $onError");
    });
    try{

      await setState(() {

        inprogress=false;
      });

    }catch(e){

    }
  }
  @override
  void initState() {
    get_device_id();
    _navigatethome();
    get_rules();
  }
  String  deviceId='';
  void get_device_id() async{

       deviceId = await PlatformDeviceId.getDeviceId;
       // print('device_id : '+ deviceId );
  }
  SharedPreferences prefs;
  var token = null;
  _navigatethome() async {
    prefs  = await SharedPreferences.getInstance();

  }

  TextEditingController _mobilecontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  bool value_check = false;

  bool inprogress=false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,

      body:   Container(
        height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin:  Alignment.topCenter,
                end:  Alignment.bottomCenter,
                colors: [Colors.white, Colors.grey[600]],
                stops: [0.01, 1]),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: SingleChildScrollView(child: Column(
              children: [
                Container(height: 50,),
                ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.asset(
                      'assets/logo.png',
                      width: 130,
                    )),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'WELCOME TO',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Image.asset('images/minilogo.png',height: 20,),
                    Text(' '),
                    Text(
                      'EnglishTurbo',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],)
               ,
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextField(textDirection: TextDirection.ltr,style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                          BorderSide(color: Colors.white, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      labelText: 'email or mobile',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    controller: _mobilecontroller,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextField(textDirection: TextDirection.ltr,style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                          BorderSide(color: Colors.white, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      labelText: 'password',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    controller: _passwordcontroller,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator
                        .of(context)
                        .push(MaterialPageRoute(builder: (_) => ForgetPassword( )));

                  },
                  child: Text(
                    'forget password',
                    style: TextStyle(color: Colors.white),
                  ) ,
                ),
                SizedBox(
                  height: 10,
                ),
              Container(padding: EdgeInsets.all(10),child:
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

            Container(height: 100,width: 300,child: Directionality(textDirection: TextDirection.rtl,
                child: CheckboxListTile(
                  value: value_check,
                  onChanged: (val){
                    setState(() {

                      if(value_check==true){
                        value_check = false;
                      }else{
                        value_check = true;

                      }
                    });
                  },
                  title:   Text(
                      widget.connect_to_backend.aboutus['rules'].toString()=='null'?'':
                      widget.connect_to_backend.aboutus['rules'].toString(),
                    style: TextStyle(color: Colors.white,fontSize: 12),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  subtitle:  Text(''),
                  activeColor: Colors.green,) ,),)

              ],)
                ,)  ,
                inprogress?Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Center(child:  Container(height: 20,width: 20,child:
                  CircularProgressIndicator(color: Colors.blue,) ,),)
                ],)
               :
                value_check==false?Container():  InkWell(
                  onTap: () {
                    if(_mobilecontroller.text==''){
                      showInSnackBar('mobile is empty');
                    }
                   else if(_passwordcontroller.text==''){
                      showInSnackBar('password is empty');
                    }else{
                      login_user(_mobilecontroller.text,_passwordcontroller.text);
                    }
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 25, color: Colors.black87,fontStyle: FontStyle.normal),
                      ),
                    ),
                    height: 55,
                    width: 280,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.grey[300], Colors.grey[300]],
                            stops: [0.1, 1]),
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator
                        .of(context)
                        .push(MaterialPageRoute(builder: (_) => SiteShow( )));

                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        'Go To Site',
                        style: TextStyle(fontSize: 12, color: Colors.black87,fontStyle: FontStyle.normal),
                      ),
                    ),
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.grey[300], Colors.grey[300]],
                            stops: [0.1, 1]),
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),),
          ),
        ),

    );
  }
}
