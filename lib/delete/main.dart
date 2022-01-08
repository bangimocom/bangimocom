import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'orderwidget.dart';

import 'paint.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Last_situation(),
//   ));
// }

class Last_situation extends StatefulWidget {
  @override
  _Last_situationState createState() => _Last_situationState();
}

class _Last_situationState extends State<Last_situation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],bottomNavigationBar: Container(color: Colors.white,height: 60,child:
      Row( children: [
       Expanded(child:  InkWell(child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.payment_outlined)],) ,),),
        Expanded(child:  InkWell(child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.payment_outlined)],) ,),),
        Expanded(child:  InkWell(child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.payment_outlined)],) ,),),
        Expanded(child:  InkWell(child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.payment_outlined)],) ,),),
        Expanded(child:  InkWell(child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.payment_outlined)],) ,),),
      ],),),
        body: Column(
          children: [
            Container(height: 20,),
            Container(
              height:80,color: CupertinoColors.white,
              child: Row(
                children: [
                  InkWell(
                    child: Icon(Icons.arrow_back_ios_outlined),
                  ),
                  Text('  '),
                  Image.asset("assets/logo.png",height: 40,),
                  Text('  '),
                  Text(
                    "Selldone",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.arrow_right_alt_rounded,
                    ),
                  ),
                  Text('  ')
                ],
              ),
            ),
            Container(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "Today sale",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "2540",
                      style: TextStyle(fontSize: 50),
                    ),
                    Text("5 new orders", style: TextStyle(fontSize: 10))
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "weekly sale",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text("80200", style: TextStyle(fontSize: 50)),
                    Text("76 Total orders", style: TextStyle(fontSize: 10))
                  ],
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(left: 20, right: 0),
                      margin: EdgeInsets.only(top: 50, right: 20),
                      child: CustomPaint(
                        size: Size(400,
                            100), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: RPSCustomPainter(),

                        child: Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            height: 150,
                            child: orderwidget()),
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}
