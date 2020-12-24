import 'package:flutter/material.dart';

class CurrentLocationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () async {
        // await getLocation();
        // mapController.moveCamera(
        //   CameraUpdate.newLatLng(
        //     latlng,
        //   ),
        // );
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
    );
  }
}
