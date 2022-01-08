import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/socket_handle.dart';



class Profile extends StatefulWidget {
  socket_handle connect_to_backend;
  Profile({@required this.connect_to_backend});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return   widget.connect_to_backend.userinfo==null?Center(child: Container(width: 20,height: 20,child:
    CircularProgressIndicator(color: Colors.purple[900],),),):
    Column(children: [

      Container(
        height: 75,
        alignment: Alignment.topCenter,
        width: double.infinity,
        child:
        Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(height: 20,color: Colors.transparent,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    'profile',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],)],
          ),


        ],),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
      Expanded(child: Column(
        children: [
          Divider(height: 20,color: Colors.transparent,),
          Center(
            child: Card( color: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child:Container(
                width: 300,padding: EdgeInsets.all(20),
                child:  Column(
                  children: [
                    Divider(height: 20,color: Colors.transparent,),
                    Image.asset(
                      'assets/avatar.png',
                      width: 100,
                      height: 100,
                    ),
                    Divider(height: 30,color: Colors.transparent,),
                    Row(children: [
                      Text('name : '),

                      Text(widget.connect_to_backend.userinfo['display_name'].toString(),style: TextStyle(fontSize: 12)),
                    ],)
                    ,
                    Divider(height: 5,color: Colors.transparent,),
                    Row(children: [
                      Text('username : '),

                      Text(widget.connect_to_backend.userinfo['user_login'].toString(),style: TextStyle(fontSize: 12)),
                    ],)
                    ,
                    Divider(height: 5,color: Colors.transparent,),
                    Row(children: [
                      Text('email : '),

                      Text(widget.connect_to_backend.userinfo['user_email'].toString(),style: TextStyle(fontSize: 12),),
                    ],),

                    Divider(height: 20,color: Colors.transparent,),
                    Container(
                      margin: EdgeInsets.only(right: 10,left: 10 , ),
                      child: InkWell(onTap: (){
                        widget.connect_to_backend.logout();

                      },child: Card(elevation: 5 ,color: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Container(
                                      child: Text('logout',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,color: Colors.grey[800],
                                              fontSize: 15)),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ) ,)
            ,
          )

        ],
      ) )

    ],) ;
  }
}
