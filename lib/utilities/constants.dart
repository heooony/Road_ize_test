import 'package:flutter/material.dart';

const kTextFieldStyle = TextStyle(fontSize: 20);
const kTextFieldDecoration = InputDecoration(
    filled: true,
    fillColor: Color(0xAAFFFFFF),
    contentPadding: EdgeInsets.all(15.0),
    hintText: '원하는 테마명을 입력하세요.',
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide.none));
