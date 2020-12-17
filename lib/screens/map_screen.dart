import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:road_ize/utilities/constants.dart';
import 'package:road_ize/services/location.dart';

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
  @override
  void initState() {
    super.initState();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.44126894283153, 127.12646818451141),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              }),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                  style: kTextFieldStyle, decoration: kTextFieldDecoration)),
          FlatButton(
              onPressed: () {
                getLocation();
              },
              child: Text('MEE!'))
        ],
      ),
    );
  }
}
