import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({this.title, this.action});
  final title;
  Widget action;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [action],
      title: Text(
        title,
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
    );
  }
}
