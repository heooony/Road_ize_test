import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final messageTextController = TextEditingController();
  final messageTextController2 = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;
  String title;
  String intro;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                controller: messageTextController,
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
                controller: messageTextController2,
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
              await _firestore
                  .collection('map_information')
                  .add({'title': title, 'intro': intro});
              messageTextController.clear();
              messageTextController2.clear();
            },
            child: Text('제출'),
            color: Colors.greenAccent,
          )
        ],
      ),
    ));
  }
}
