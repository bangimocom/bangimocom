import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree


//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
@override
void paint(Canvas canvas, Size size) {

Path path_0 = Path();
path_0.moveTo(0,size.height*0.1430939);
path_0.lineTo(0,size.height*0.2303867);
path_0.cubicTo(size.width*0.01249156,size.height*0.2303867,size.width*0.02261985,size.height*0.2635359,size.width*0.02261985,size.height*0.3044199);
path_0.cubicTo(size.width*0.02261985,size.height*0.3453039,size.width*0.01249156,size.height*0.3784530,0,size.height*0.3784530);
path_0.lineTo(0,size.height*0.8569061);
path_0.cubicTo(0,size.height*0.9359116,size.width*0.01958136,size.height,size.width*0.04372046,size.height);
path_0.lineTo(size.width*0.9564483,size.height);
path_0.cubicTo(size.width*0.9804186,size.height,size.width*1.000000,size.height*0.9359116,size.width*1.000000,size.height*0.8569061);
path_0.lineTo(size.width*1.000000,size.height*0.3784530);
path_0.cubicTo(size.width*0.9875084,size.height*0.3784530,size.width*0.9773801,size.height*0.3453039,size.width*0.9773801,size.height*0.3044199);
path_0.cubicTo(size.width*0.9773801,size.height*0.2635359,size.width*0.9875084,size.height*0.2303867,size.width*1.000000,size.height*0.2303867);
path_0.lineTo(size.width*1.000000,size.height*0.1430939);
path_0.cubicTo(size.width*1.000000,size.height*0.06408840,size.width*0.9804186,size.height*9.814126e-17,size.width*0.9564483,size.height*9.814126e-17);
path_0.lineTo(size.width*0.04372046,size.height*9.814126e-17);
path_0.cubicTo(size.width*0.01958136,size.height*9.814126e-17,size.width*-5.997153e-17,size.height*0.06408840,size.width*-5.997153e-17,size.height*0.1430939);
path_0.close();

Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
paint_0_fill.color = Color(0xffffffff).withOpacity(1.0);
canvas.drawPath(path_0,paint_0_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
return true;
}
}