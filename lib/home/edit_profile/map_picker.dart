
import 'dart:async';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/home/edit_profile/fullscreen_dialog.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
class map_picker extends StatefulWidget {
  bool have_float;
  map_picker({@required this.have_float});

  @override
  State<StatefulWidget> createState() {
    return new map_picker_page();
  }
}

class map_picker_page extends State<map_picker> {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  @override
  void initState()  {
    get_loc();
    super.initState();
  }
  void get_loc() async{
    Location location = new Location();


    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return;
      }
    }

    _locationData = await location.getLocation();
    await  setState(() {

    });
    mm= await  Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(_locationData.latitude==null?24.20:_locationData.latitude,
          _locationData.longitude==null?24.20:_locationData.longitude),
      builder: (ctx) =>
          Container(
            child: Icon(
              Icons.location_pin,
              size: 40,
              color: Colors.black,
            ),
          ),
    );
  }
  Marker mm;
  @override
  Widget build(BuildContext context) {
    return  _locationData==null?Scaffold(
        backgroundColor: Colors.white,
        body:Center(child: CircularProgressIndicator(),) ) :
    Scaffold(body: FlutterMap(
      options: MapOptions(
          center: LatLng(_locationData.latitude==null?24.20:_locationData.latitude,
              _locationData.longitude==null?24.20:_locationData.longitude),
          zoom: 18.0,onTap: (latlang) async{
        mm= await Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(latlang.latitude,latlang.longitude),
          builder: (ctx) =>
              Container(
                child: Icon(
                  Icons.location_pin,
                  size: 40,
                  color: Colors.black,
                ),
              ),
        );
        await  setState(() {

        });
        print('yess');
      }
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: [
            mm
          ],
        ),
      ],
    ),floatingActionButton:widget.have_float==null?Container(): widget.have_float?FloatingActionButton(
      backgroundColor: Colors.white,child: Icon(Icons.check  ,),onPressed: (){

      Navigator.pop(context);

    },):
    FloatingActionButton(
      backgroundColor: Colors.white,
      child: Icon(Icons.fullscreen  ,),onPressed: (){

      Navigator.of(context).push(fullscreen_dialog(widget: map_picker(have_float: true,)));

    },)
      ,)
    ;
  }
}