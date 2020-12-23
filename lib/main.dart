import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:road_ize/screens/introduce_screen.dart';
import 'package:road_ize/screens/login_screen.dart';
import 'package:road_ize/utilities/firebase_information.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainScreen());
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'nixgone_m',
      ),
      home: StreamBuilder(
        stream: FirebaseInformation.auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data == null) {
              return LoginScreen();
            } else
              return IntroduceScreen();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
