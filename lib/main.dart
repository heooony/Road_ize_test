import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:road_ize/screens/login_screen.dart';
import 'package:road_ize/screens/introduce_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}
