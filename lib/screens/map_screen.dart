import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

class MyMapScreenState extends State<MyMapScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  GoogleMapController mapController;
  Location location = Location();
  LatLng latlng;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void getLocation() async {
    await location.getCurrentLocation();
    print(location.latitude);
    latlng = LatLng(location.latitude, location.longitude);
  }

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: latlng,
              zoom: 14.4746,
            ),
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                  style: kTextFieldStyle, decoration: kTextFieldDecoration)),
          Center(child: Icon(Icons.add)),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RawMaterialButton(
                  onPressed: () {
                    mapController.moveCamera(
                      CameraUpdate.newLatLng(
                        latlng,
                      ),
                    );
                  },
                  shape: CircleBorder(),
                  elevation: 5.0,
                  hoverColor: Colors.white,
                  child: Icon(
                    Icons.location_searching,
                    size: 40,
                    color: Colors.grey,
                  ),
                  fillColor: Colors.white,
                  constraints: BoxConstraints.tightFor(width: 60, height: 60),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
