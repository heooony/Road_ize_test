import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:road_ize/services/google_map.dart';
import 'package:road_ize/utilities/constants.dart';
import 'package:road_ize/services/location.dart';
import '../services/location.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyMapScreen();
  }
}

class MyMapScreen extends StatefulWidget {
  @override
  State<MyMapScreen> createState() => MyMapScreenState();
}

class MyMapScreenState extends State<MyMapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    LatLng _lastLongPress;
    return Scaffold(
      body: Stack(
        children: [
          MyGoogleMap(),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                  style: kTextFieldStyle, decoration: kTextFieldDecoration)),
          Center(child: Icon(Icons.add)),
        ],
      ),
    );
  }
}
