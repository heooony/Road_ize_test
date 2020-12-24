import 'package:flutter/material.dart';
import 'package:road_ize/utilities/firebase_information.dart';

class MyCard extends StatelessWidget {
  String title;
  String intro;
  final nameController = TextEditingController();
  final introController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Card(
      margin: EdgeInsets.only(
          left: 50.0, right: 50.0, top: 40.0, bottom: height / 2),
      color: Color(0xEEFFFFFF),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('TITLE : '),
                Container(
                  width: 190.0,
                  child: TextField(
                    controller: nameController,
                    style: TextStyle(fontSize: 20.0),
                    onChanged: (value) {
                      title = value;
                    },
                    decoration: InputDecoration(
                        hintText: 'title',
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text('INTRODUCE : '),
                Container(
                  width: 190.0,
                  child: TextField(
                    controller: introController,
                    style: TextStyle(fontSize: 20.0),
                    onChanged: (value) {
                      intro = value;
                    },
                    maxLines: 3,
                    decoration: InputDecoration(
                        hintText: 'intro',
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                )
              ],
            ),
            RaisedButton(
              onPressed: () {
                nameController.clear();
                introController.clear();
                FirebaseInformation.uploadThema(title, intro);
              },
              color: Colors.lightGreen,
              child: Text(
                '확인',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
