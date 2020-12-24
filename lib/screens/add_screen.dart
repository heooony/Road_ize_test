import 'package:flutter/material.dart';
import 'package:road_ize/services/user_stream.dart';
import 'package:road_ize/utilities/firebase_information.dart';
import 'package:road_ize/utilities/snackBar.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final titleController = TextEditingController();
  final introController = TextEditingController();
  String title;
  String intro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '제목 : ',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                Flexible(
                    child: TextField(
                  controller: titleController,
                  onChanged: (value) {
                    title = value;
                  },
                  style: TextStyle(fontSize: 30.0, color: Colors.black),
                  decoration: InputDecoration(
                      hintText: '테마 이름을 적어주세요', border: OutlineInputBorder()),
                )),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  '설명 : ',
                  style: TextStyle(fontSize: 30.0),
                ),
                Expanded(
                    child: TextField(
                  controller: introController,
                  onChanged: (value) {
                    intro = value;
                  },
                  maxLines: 3,
                  style: TextStyle(fontSize: 30.0),
                  decoration: InputDecoration(
                      hintText: '테마 설명을 적어주세요', border: OutlineInputBorder()),
                )),
              ],
            ),
            FlatButton(
              onPressed: () async {
                UserStream();
                await FirebaseInformation.firestore
                    .collection('user_information')
                    .doc(FirebaseInformation.user.uid)
                    .collection('map_information')
                    .doc(title)
                    .get()
                    .then((value) async {
                  if (value.data() == null) {
                    await FirebaseInformation.firestore
                        .collection('user_information')
                        .doc(FirebaseInformation.user.uid)
                        .collection('map_information')
                        .doc(title)
                        .set({'title': title, 'intro': intro});
                    titleController.clear();
                    introController.clear();
                  } else {
                    MySnackBar(scaffoldKey: scaffoldKey, text: '해당 제목이 존재합니다.')
                        .snackBarUp();
                  }
                });
              },
              child: Text('제출'),
              color: Colors.greenAccent,
            )
          ],
        ),
      )),
    );
  }
}
