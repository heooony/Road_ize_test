import 'package:flutter/material.dart';
import 'package:road_ize/services/map_stream.dart';
import 'package:road_ize/utilities/firebase_information.dart';

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
    name = await FirebaseInformation.storeGetData('user_information', 'name');
    intro = await FirebaseInformation.storeGetData('user_information', 'intro');
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
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.black,
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(fontSize: 40),
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
                  MapStream()
                ],
              ),
            );
          }
        });
  }
}
