
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:kenburns/kenburns.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

import 'code.dart';
import '../defines.dart';

class login extends StatefulWidget {
  @override
  MyHomePage createState() => new MyHomePage();
}

Random rnd = new Random();
int mini = 1000;
int max = 9999;
String phone = "";
String captcha = "";
int r;
class MyHomePage extends State<login> with SingleTickerProviderStateMixin {
  TextEditingController phoneedit = new TextEditingController();
  TextEditingController nameedit = new TextEditingController();
  TextEditingController captchaedit = new TextEditingController();
  SharedPreferences prefs;
 bool progressenable=false;
  Future post_to_server(String phone,String name, BuildContext contextme) async {
    setState(() {
      progressenable =true;
    });
    try {
      Dio dio = new Dio();
      FormData formData = FormData.fromMap({
        "command": "login_user",
        "mobile": phone,
        "name": name,
//      "image": await MultipartFile.fromFile(_path,filename: "upload1.png"),
//      "files": [
//        await MultipartFile.fromFile(_path,filename: "upload2.png"),
//        await MultipartFile.fromFile(_path,filename: "upload3.png"),
//      ]
      });

      Response response =
      await dio.post(defines().request_url, data: formData);
      print(response.data.toString());
      prefs.setString("mobile", phone);

      if(response.data.toString()=="yes"){
//prefs.setString("mobile", phone);
////        int counter = (prefs.getInt('counter') ?? 0) + 1;
////        print('Pressed $counter times.');
//
////        Navigator.pushAndRemoveUntil(
////          contextme,
////          MaterialPageRoute(builder: (contextme) => home_page()),
////              (Route<dynamic> route) => false,
////        );
//        Navigator
//            .of(context)
//            .push(MaterialPageRoute(builder: (_) => code()));

        Navigator
            .of(context)
            .push(MaterialPageRoute(builder: (_) => code(mobile: phone,)));
      }
      setState(() {
        progressenable =false;
      });
    } catch (e) {
      print(e.toString());

    }
  }
  @override
  void initState() {
    init_shared();
  }
  void init_shared() async {
    prefs = await SharedPreferences.getInstance();
  }
  void posting(BuildContext context){
    if (nameedit.text =="") {
      show_snackbar(
          'نام خالی است',
          context);
    }else if (!phoneedit.text
        .startsWith("09")) {
      show_snackbar(
          'شماره موبایل صحیح نیست',
          context);
    } else if (phoneedit
        .text.length !=
        11) {
      show_snackbar(
          'شماره موبایل صحیح نیست',
          context);
    } else if (captchaedit.text !=
        r.toString()) {
      show_snackbar(
          'کد تصویری صحیح نیست',
          context);
    } else {
      post_to_server(
          phoneedit.text,
          nameedit.text,
          context);

    }
  }
  // homepage layout
  @override
  Widget build(BuildContext contexttt) {
     r = mini + rnd.nextInt(max - mini);
    print(r.toString());

    return    Scaffold(key: _scaffoldKey,
              body: Builder(
                  builder: (context) => Stack(
                    children: <Widget>[
                      KenBurns(
                        child: Image.asset(
                          "assets/background.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        heightFactor: 20,
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          child: Wrap(
                            children: <Widget>[
                              Card(
                                color: Colors.white,
                                elevation: 5,
                                child: Padding(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: <Widget>[
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child:   TextFormField(
                                          textDirection:
                                          TextDirection.rtl,
                                          decoration:
                                          InputDecoration(
                                            labelText: 'نام',
                                          ),
                                          keyboardType:
                                          TextInputType.text,
                                          onSaved: (String value) {
                                            // This optional block of code can be used to run
                                            // code when the user saves the form.
                                          },
                                          validator: (String value) {},
                                          controller: nameedit,
                                        ),
                                      ),
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child:   TextFormField(
                                          textDirection:
                                          TextDirection.ltr,
                                          decoration:
                                          InputDecoration(
                                            labelText: 'شماره موبایل',
                                          ),
                                          keyboardType:
                                          TextInputType.number,
                                          onSaved: (String value) {
                                            // This optional block of code can be used to run
                                            // code when the user saves the form.
                                          },
                                          validator: (String value) {},
                                          controller: phoneedit,
                                        ),
                                      ),
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          textDirection:
                                          TextDirection.ltr,
                                          decoration:
                                          const InputDecoration(
                                            labelText: 'کد تصویری',
                                          ),
                                          keyboardType:
                                          TextInputType.number,
                                          controller: captchaedit,
                                        ),
                                      ),
                                      Divider(
                                        height: 30,
                                      ),
                                      Text(
                                        r.toString(),
                                        style: TextStyle(
                                          fontSize: 40,
                                          wordSpacing: 1,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.refresh),
                                        onPressed: () {
                                          setState(() {});
                                        },
                                      ),
                                      MaterialButton(
                                        elevation: 5,
                                        child:  progressenable ==true ? CircularProgressIndicator() :    RawMaterialButton(
                                          fillColor: Colors.black,
                                          splashColor: Colors.black,
                                          child:Padding (child:  Text("ورود",style: TextStyle(color: Colors.white),),
                                            padding: EdgeInsets.only(
                                                right: 0,left: 0,
                                                bottom: 0.0,top: 0),
                                          ) ,
                                          onPressed: (){

                                            progressenable ==true ? null :  posting( context);
                                          },
                                          shape:  StadiumBorder(),
                                        ),
                                        onPressed:(){
                                        }
                                        ,
                                      )
                                    ],
                                  ),
                                  padding: EdgeInsets.all(20.0),
                                ),
                              )
                            ],
                          ),
                          padding: EdgeInsets.all(8.0),
                        )
                        //  Text(r.toString(),style: TextStyle(fontFamily: 'meysam'),),

                        ,
                      ),
                    ],
                  ))
          );


  }

  GlobalKey<ScaffoldState> _scaffoldKey =   GlobalKey<ScaffoldState>();


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


