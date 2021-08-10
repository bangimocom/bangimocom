
 import 'package:flutter/cupertino.dart';

class defines{

static  String domain= "http://192.168.1.102:9855";
// static  String domain= "https://server.parvanehawz.ir";
//   static  String domain= "http://192.168.43.231:8081";
  final String request_url=domain+"/request";
 final String folder_slider=domain+"/image/tanzimat_zaheri_froshgah/";
 final String image_products=domain+"/image/img_mahsulat/";
 // final   String request_payment= "192.168.43.202/other/gallery_parvaneh_payment/payment_pre.php";
   final   String request_payment= "https://server.parvanehawz.ir/payment/payment_pre.php";
 final String image_folder=domain+"/";

  double height_appbar(BuildContext context){
  return ((MediaQuery.of(context).size.height)/11).ceilToDouble();
  }
 final String version="1";
 }