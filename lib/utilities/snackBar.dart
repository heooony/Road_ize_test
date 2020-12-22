import 'package:flutter/material.dart';

class MySnackBar {
  MySnackBar({@required this.scaffoldKey, @required this.text});

  final scaffoldKey;
  String text;

  void snackBarUp() {
    final snackBar = SnackBar(
        content: Text(
          text,
          style: TextStyle(fontSize: 15.0),
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
