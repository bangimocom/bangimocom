

import 'dart:ui';

import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree


//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xffffc861).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width*0.5000197,size.height*17.03935),size.width*0.4687795,paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width*0.9135130,size.height*16.99087);
    path_1.cubicTo(size.width*0.9619146,size.height*17.32539,size.width*0.5629317,size.height*17.60221,size.width*0.2678221,size.height*17.38351);
    path_1.cubicTo(size.width*0.2450209,size.height*17.37011,size.width*0.2168345,size.height*17.38984,size.width*0.2210439,size.height*17.41595);
    path_1.cubicTo(size.width*0.3016665,size.height*17.47593,size.width*0.3995156,size.height*17.50789,size.width*0.4999996,size.height*17.50809);
    path_1.cubicTo(size.width*0.7588831,size.height*17.50809,size.width*0.9687496,size.height*17.29822,size.width*0.9687496,size.height*17.03934);
    path_1.cubicTo(size.width*0.9687479,size.height*17.01273,size.width*0.9664819,size.height*16.98618,size.width*0.9619748,size.height*16.95996);
    path_1.cubicTo(size.width*0.9378106,size.height*16.94579,size.width*0.9100134,size.height*16.96471,size.width*0.9135130,size.height*16.99087);
    path_1.close();

    Paint paint_1_fill = Paint()..style=PaintingStyle.fill;
    paint_1_fill.color = Color(0xffffab61).withOpacity(1.0);
    canvas.drawPath(path_1,paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width*0.3574218,size.height*17.01255);
    path_2.arcToPoint(Offset(size.width*0.3173830,size.height*17.05259),radius: Radius.elliptical(size.width*0.04003906, size.height*0.04003906),rotation: 0 ,largeArc: false,clockwise: false);
    path_2.arcToPoint(Offset(size.width*0.3574218,size.height*17.09263),radius: Radius.elliptical(size.width*0.04003906, size.height*0.04003906),rotation: 0 ,largeArc: false,clockwise: false);
    path_2.arcToPoint(Offset(size.width*0.3974611,size.height*17.05259),radius: Radius.elliptical(size.width*0.04003906, size.height*0.04003906),rotation: 0 ,largeArc: false,clockwise: false);
    path_2.arcToPoint(Offset(size.width*0.3574218,size.height*17.01255),radius: Radius.elliptical(size.width*0.04003906, size.height*0.04003906),rotation: 0 ,largeArc: false,clockwise: false);
    path_2.close();
    path_2.moveTo(size.width*0.6425783,size.height*17.01255);
    path_2.arcToPoint(Offset(size.width*0.6025389,size.height*17.05259),radius: Radius.elliptical(size.width*0.04003906, size.height*0.04003906),rotation: 0 ,largeArc: false,clockwise: false);
    path_2.arcToPoint(Offset(size.width*0.6425783,size.height*17.09263),radius: Radius.elliptical(size.width*0.04003906, size.height*0.04003906),rotation: 0 ,largeArc: false,clockwise: false);
    path_2.arcToPoint(Offset(size.width*0.6826171,size.height*17.05259),radius: Radius.elliptical(size.width*0.04003906, size.height*0.04003906),rotation: 0 ,largeArc: false,clockwise: false);
    path_2.arcToPoint(Offset(size.width*0.6425783,size.height*17.01255),radius: Radius.elliptical(size.width*0.04003906, size.height*0.04003906),rotation: 0 ,largeArc: false,clockwise: false);
    path_2.close();

    Paint paint_2_fill = Paint()..style=PaintingStyle.fill;
    paint_2_fill.color = Color(0xff4d4d4d).withOpacity(1.0);
    canvas.drawPath(path_2,paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width*0.3547927,size.height*17.21904);
    path_3.cubicTo(size.width*0.3390114,size.height*17.23347,size.width*0.3614736,size.height*17.25677,size.width*0.3764772,size.height*17.24153);
    path_3.cubicTo(size.width*0.4293545,size.height*17.19777,size.width*0.5109108,size.height*17.14886,size.width*0.5719821,size.height*17.18639);
    path_3.cubicTo(size.width*0.5903323,size.height*17.19827,size.width*0.6070691,size.height*17.16947,size.width*0.5876683,size.height*17.15940);
    path_3.cubicTo(size.width*0.5061209,size.height*17.11530,size.width*0.4219738,size.height*17.16038,size.width*0.3547927,size.height*17.21904);
    path_3.close();

    Paint paint_3_fill = Paint()..style=PaintingStyle.fill;
    paint_3_fill.color = Color(0xff4d4d4d).withOpacity(1.0);
    canvas.drawPath(path_3,paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width*0.2752536,size.height*17.00836);
    path_4.cubicTo(size.width*0.2544154,size.height*17.00836,size.width*0.2544154,size.height*17.03962,size.width*0.2752536,size.height*17.03962);
    path_4.lineTo(size.width*0.7205124,size.height*17.03962);
    path_4.cubicTo(size.width*0.7413506,size.height*17.03962,size.width*0.7413506,size.height*17.00836,size.width*0.7205124,size.height*17.00836);
    path_4.close();

    Paint paint_4_fill = Paint()..style=PaintingStyle.fill;
    paint_4_fill.color = Color(0xff4d4d4d).withOpacity(1.0);
    canvas.drawPath(path_4,paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width*0.5662664,size.height*16.76468);
    path_5.cubicTo(size.width*0.5846465,size.height*16.77945,size.width*0.5744054,size.height*16.80047,size.width*0.5639595,size.height*16.81116);
    path_5.cubicTo(size.width*0.5491958,size.height*16.82592,size.width*0.5713414,size.height*16.84807,size.width*0.5861052,size.height*16.83331);
    path_5.cubicTo(size.width*0.6176517,size.height*16.80172,size.width*0.6140267,size.height*16.76022,size.width*0.5839137,size.height*16.73884);
    path_5.cubicTo(size.width*0.5656603,size.height*16.72818,size.width*0.5494433,size.height*16.75250,size.width*0.5662664,size.height*16.76468);
    path_5.close();

    Paint paint_5_fill = Paint()..style=PaintingStyle.fill;
    paint_5_fill.color = Color(0xffef6356).withOpacity(1.0);
    canvas.drawPath(path_5,paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width*0.6720495,size.height*16.70103);
    path_6.cubicTo(size.width*0.6575124,size.height*16.71960,size.width*0.6363669,size.height*16.70963,size.width*0.6255409,size.height*16.69932);
    path_6.cubicTo(size.width*0.6105919,size.height*16.68475,size.width*0.5887286,size.height*16.70717,size.width*0.6036790,size.height*16.72175);
    path_6.cubicTo(size.width*0.6356614,size.height*16.75289,size.width*0.6771092,size.height*16.74874,size.width*0.6981085,size.height*16.71835);
    path_6.cubicTo(size.width*0.7085331,size.height*16.69996,size.width*0.6840085,size.height*16.68406,size.width*0.6720483,size.height*16.70104);
    path_6.close();

    Paint paint_6_fill = Paint()..style=PaintingStyle.fill;
    paint_6_fill.color = Color(0xffef6356).withOpacity(1.0);
    canvas.drawPath(path_6,paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width*0.6846579,size.height*16.86748);
    path_7.cubicTo(size.width*0.6685973,size.height*16.85021,size.width*0.6483747,size.height*16.86195,size.width*0.6384628,size.height*16.87314);
    path_7.cubicTo(size.width*0.6248036,size.height*16.88893,size.width*0.6011170,size.height*16.86844,size.width*0.6147760,size.height*16.85265);
    path_7.cubicTo(size.width*0.6439991,size.height*16.81890,size.width*0.6856501,size.height*16.81952,size.width*0.7091528,size.height*16.84801);
    path_7.cubicTo(size.width*0.7211012,size.height*16.86545,size.width*0.6980145,size.height*16.88338,size.width*0.6846579,size.height*16.86748);
    path_7.close();

    Paint paint_7_fill = Paint()..style=PaintingStyle.fill;
    paint_7_fill.color = Color(0xffef6356).withOpacity(1.0);
    canvas.drawPath(path_7,paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width*0.7404966,size.height*16.75738);
    path_8.cubicTo(size.width*0.7230277,size.height*16.77322,size.width*0.7345015,size.height*16.79359,size.width*0.7455623,size.height*16.80364);
    path_8.cubicTo(size.width*0.7611803,size.height*16.81750,size.width*0.7403903,size.height*16.84092,size.width*0.7247744,size.height*16.82706);
    path_8.cubicTo(size.width*0.6914049,size.height*16.79741,size.width*0.6925537,size.height*16.75577,size.width*0.7213433,size.height*16.73264);
    path_8.cubicTo(size.width*0.7389301,size.height*16.72091,size.width*0.7565660,size.height*16.74422,size.width*0.7404953,size.height*16.75738);
    path_8.close();

    Paint paint_8_fill = Paint()..style=PaintingStyle.fill;
    paint_8_fill.color = Color(0xffef6356).withOpacity(1.0);
    canvas.drawPath(path_8,paint_8_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}