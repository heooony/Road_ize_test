import 'package:flutter/material.dart';
import 'package:road_ize/services/google_map.dart';

class ThemaAddScreen extends StatefulWidget {
  @override
  _ThemaAddScreenState createState() => _ThemaAddScreenState();
}

class _ThemaAddScreenState extends State<ThemaAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Google Map에서 지점 찍기',
          style: TextStyle(color: Colors.black),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black,
            );
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: MyGoogleMap(),
      ),
    );
  }
}
