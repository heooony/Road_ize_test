import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/flutter_login.dart';
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

  Future<String> isCurrentUser(LoginData data) async {
    try {
      final user = (await _auth.signInWithEmailAndPassword(
              email: data.name, password: data.password))
          .user;
    } catch (e) {}
  }

  Future<String> createUser(LoginData data) async {
    try {
      final newUser = (await _auth.createUserWithEmailAndPassword(
              email: data.name, password: data.password))
          .user;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'ROAD_IZE',
      logo: 'Thanks',
      onLogin: isCurrentUser,
      onSignup: createUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => BottomNavigation(),
        ));
      },
    );
  }
}
