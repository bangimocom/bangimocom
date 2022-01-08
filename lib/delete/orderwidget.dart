import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dash.dart';

class orderwidget extends StatefulWidget {
  @override
  _orderwidgetState createState() => _orderwidgetState();
}

class _orderwidgetState extends State<orderwidget> {
  List<String> PhysicalOrderStates = [
    'CheckQueue',
    "OrderConfirm",
    "PreparingOrder",
    "SentOrder",
    "ToCustomer"
  ];
  List<IconData> OrderIcons = [
    Icons.shopping_basket,
    Icons.check,
    Icons.shopping_cart,
    Icons.bus_alert,
    Icons.check_box_outlined
  ];
  int CurrentState = 0;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
    Expanded(child:  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left:0 ,top: 35 ),

          child: Row(
            children: [
              Expanded(child: Row(children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.06,
                  height:  MediaQuery.of(context).size.width*0.06,
                  decoration: BoxDecoration(
                      color: CurrentState > 1 ? Colors.black : Colors.black,
                      borderRadius: BorderRadius.circular(100)),
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                    Icon(
                      CurrentState > 0 ? Icons.check : OrderIcons[0],
                      color: Colors.white,size:  MediaQuery.of(context).size.width*0.045,
                    ),

                  ],),

                ),



                Container(
                  color: Colors.grey,
                  height: 2,
                  width: MediaQuery.of(context).size.width*0.02,
                ),
                Container(
                  child: Icon(
                    CurrentState > 1 ? Icons.check : OrderIcons[1],
                    color: CurrentState > 0 ? Colors.white : Colors.grey,size:  MediaQuery.of(context).size.width*0.045,

                  ),
                  width: MediaQuery.of(context).size.width*0.06,
                  height: MediaQuery.of(context).size.width*0.06,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: CurrentState > 0 ? Colors.black : Colors.grey,
                        width: 1,
                      ),
                      color: CurrentState > 0 ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                ),
                Container(
                  color: Colors.grey,
                  height: 2,
                  width: MediaQuery.of(context).size.width*0.02,
                ),

                Container( width: MediaQuery.of(context).size.width*0.06,
                  height: MediaQuery.of(context).size.width*0.06,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: CurrentState > 1 ? Colors.black : Colors.grey,
                        width: 1,
                      ),
                      color: CurrentState > 1 ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(
                      CurrentState > 2 ? Icons.check : OrderIcons[2],
                      color: CurrentState > 1 ? Colors.white : Colors.grey,size:  MediaQuery.of(context).size.width*0.045,
                    ),

                    //text preparing
                  ],),


                ),



                Container(
                  color: Colors.grey,
                  height: 2,
                  width: MediaQuery.of(context).size.width*0.02,
                ),
                Container(
                  child: Icon(
                    CurrentState > 3 ? Icons.check : OrderIcons[3],
                    color: CurrentState > 2 ? Colors.white : Colors.grey,size:  MediaQuery.of(context).size.width*0.045,
                  ),
                  width: MediaQuery.of(context).size.width*0.06,
                  height: MediaQuery.of(context).size.width*0.06,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: CurrentState > 2 ? Colors.black : Colors.grey,
                        width: 1,
                      ),
                      color: CurrentState > 2 ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                ) ,
                Container(
                  color: Colors.grey,
                  height: 2,
                  width: MediaQuery.of(context).size.width*0.02,
                ),

                Container(
                  width: MediaQuery.of(context).size.width*0.06,
                  height: MediaQuery.of(context).size.width*0.06,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: CurrentState > 3 ? Colors.black : Colors.grey,
                        width: 1,
                      ),
                      color: CurrentState > 3 ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(
                      CurrentState > 4 ? Icons.check : OrderIcons[4],
                      color: CurrentState > 3 ? Colors.white : Colors.grey,size:  MediaQuery.of(context).size.width*0.045,
                    ),

                  ],),


                ),

              ],),)




            ],
          ),

        ),
        Row(children: [
          Container(width: MediaQuery.of(context).size.width*0.14,),
          Container(margin: EdgeInsets.only(right: 0),
            child: Text(
              "preparing",overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey, fontSize: 8),
            ),
          )
          ,
        ],),
        Container(height: 8,),
       Row(children: [
         Text(
           "3 days ago",
           style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold, color: Colors.grey[600]),
         ),
    Text('  '),
   Expanded(child: Container()),
         Image.asset(
           'assets/logo.png',
           width: 20,
           height: 20,
         ),
         Container(width: 8,)
       ],) ,
        Text(
          "Monday,21st December 2020,4:02:29",style: TextStyle(color: Colors.grey,fontSize: 10,),),





      ],
    ),),
      //left widget

      CustomPaint(
          size: Size(1, 130),
          painter: DashedLineVerticalPainter()),

      //dashline
    Expanded(child:    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("730",style: TextStyle(fontSize: 40,color: Colors.purple),),
          Container(width: 8,),
          Column(children: [
            Icon(
              Icons.check,color: Colors.green,size: 30,),
            Text("Paid",style: TextStyle(
                fontSize: 10,color: Colors.grey
            )
              ,),

          ],)
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_basket_outlined,color: Colors.grey,),
          Container(width: 8,),
          Text("SM-164")
        ],
      )
    ],),)

      //right widget

    ],);

  }
}
