import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:road_ize/utilities/firebase_information.dart';
import 'introduce_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => Duration(milliseconds: 2250);

  // ignore: missing_return
  Future<String> _authUser(LoginData data) async {
    try {
      await FirebaseInformation.auth.signInWithEmailAndPassword(
          email: data.name, password: data.password);
      FirebaseInformation.user = FirebaseInformation.auth.currentUser;
    } catch (e) {
      return 'User not exists';
    }
  }

  // ignore: missing_return
  Future<String> _authCreateUser(LoginData data) async {
    try {
      await FirebaseInformation.auth.createUserWithEmailAndPassword(
          email: data.name, password: data.password);
      _authUser(data);
    } catch (e) {
      return 'Error : $e';
    }
  }

  // Future<String> _recoverPassword(String name) {
  //   print('Name: $name');
  //   return Future.delayed(loginTime).then((_) {
  //     if (!users.containsKey(name)) {
  //       return 'Username not exists';
  //     }
  //     return null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
        title: 'ROAD_IZE',
        logo: 'Thanks',
        onLogin: _authUser,
        onSignup: _authCreateUser,
        // onRecoverPassword: _recoverPassword,
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => IntroduceScreen(),
          ));
        });
  }
}
