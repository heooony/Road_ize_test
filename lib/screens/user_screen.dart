import 'package:flutter/material.dart';
import 'package:road_ize/services/map_stream.dart';
import 'package:road_ize/utilities/constants.dart';
import 'package:road_ize/utilities/firebase_information.dart';
import 'package:road_ize/screens/login_screen.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String name;
  String intro;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    name = await FirebaseInformation.getStoreData('user_information', 'name');
    intro = await FirebaseInformation.getStoreData('user_information', 'intro');
    return 'finish';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Scaffold(
              body: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      FlatButton(
                          onPressed: () {
                            FirebaseInformation.signOut();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            '로그아웃',
                            style: TextStyle(fontSize: 30.0),
                          )),
                      FlatButton(
                          onPressed: () {
                            FirebaseInformation.signOut();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            '구독',
                            style: TextStyle(fontSize: 30.0),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blue,
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(fontSize: 30),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              '구독자 수 : 0',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              '테마 수 : 0',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              '지점 수 : 0',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '소개',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(intro, style: TextStyle(fontSize: 20.0))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  MapStream()
                ],
              ),
            );
          }
        });
  }
}
