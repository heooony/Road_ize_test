import 'package:flutter/material.dart';
import 'package:road_ize/services/location.dart';
import '../services/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:road_ize/components/add_map_card.dart';

class MyGoogleMap extends StatefulWidget {
  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  LatLng _lastLongPress;
  GoogleMapController mapController;
  bool popCard = false;
  Location location = Location();
  LatLng latlng = LatLng(0.0, 0.0);
  LatLngBounds _visibleRegion = LatLngBounds(
    southwest: const LatLng(0, 0),
    northeast: const LatLng(0, 0),
  );

  void _onMapCreated(GoogleMapController controller) async {
    final LatLngBounds visibleRegion = await controller.getVisibleRegion();
    mapController = controller;
    setState(() {
      _visibleRegion = visibleRegion;
    });
  }

  Future<LatLng> getLocation() async {
    await location.getCurrentLocation();
    latlng = LatLng(location.latitude, location.longitude);
    return latlng;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: getLocation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == false) {
              return Center(child: CircularProgressIndicator());
            } else {
              return GoogleMap(
                onMapCreated: _onMapCreated,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: latlng,
                  zoom: 14.4746,
                ),
                onTap: (LatLng pos) {
                  setState(() {
                    popCard = false;
                  });
                },
                onLongPress: (LatLng pos) {
                  setState(() {
                    popCard = true;
                  });
                  _lastLongPress = pos;
                  mapController.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(target: _lastLongPress, zoom: 17)));
                },
              );
            }
          },
        ),
        Center(
            child: popCard
                ? Icon(
                    Icons.add_location_alt_outlined,
                    size: 30.0,
                  )
                : Icon(Icons.add, size: 30.0)),
        popCard ? MyCard() : Container(),
        Text('${_visibleRegion.northeast}'),
      ],
    );
  }
}
