
 import 'package:flutter/cupertino.dart';

class defines{

static  String domain= "https://appback.englishturbo.com";
static  String domain2= "https://appvid.englishturbo.com";
//   static  String domain2= "http://192.168.1.102:8012/turbo/adminpanel";
//   static  String domain= "http://192.168.1.102:9855";
  // static  String domain= "http://192.168.43.202:9855";
    final String request_url2=domain+"/request";
  final  String password = 'ewrte5467657hfghukkju76567421wdsdsfgthyu7i87iyhnhgkluo8yit35786sfzxcaderwr434556hu989o08khghbvfdvsdccasxs4t5465gerffer2423tgdds';



  static String pre="https://englishturbo.com";
  // static String pre="http://192.168.1.102:8012/wordpress";
  // static String pre="http://192.168.43.202:8012/wordpress";
  final String home_request = pre + "/wp-json/method/get_home";
  final String login_request = pre + "/wp-json/method/login";
  final String rules_request = pre + "/wp-json/method/rules";
 final String video_folder= domain2+"/";
 final String image_folder=domain+"/";

  double height_appbar(BuildContext context){
  return ((MediaQuery.of(context).size.height)/11).ceilToDouble();
  }
 final String version="1";
 }