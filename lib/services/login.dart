import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:road_ize/utilities/bottom_navigation.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    isCurrentUser();
  }

  void isCurrentUser() async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: 'oueya1479@naver.com', password: '123456');
      if (user != null) {
        print("로그인 성공@@@@@@@@@@@@@@@@@@@@@@@@@@");
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyBottomNavigation());
  }
}
