import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:road_ize/utilities/bottom_navigation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  Future<void> isCurrentUser() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
            email: 'oueya1479@naver.com', password: '123456'))
        .user;
    print('@@@@@@@@@@@@@@@@@@@@@@@@@$user');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        body: Container(
          child: FlatButton(color: Colors.black, onPressed: isCurrentUser),
        ),
      ),
    ));
  }
}
