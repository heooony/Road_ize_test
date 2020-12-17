import 'package:flutter/material.dart';
import 'package:road_ize/utilities/constants.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child:
          TextField(style: kTextFieldStyle, decoration: kTextFieldDecoration),
    );
  }
}
