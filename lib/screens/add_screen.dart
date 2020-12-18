import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:road_ize/utilities/constants.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
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
                  child: TextFormField(
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
                maxLines: 3,
                style: TextStyle(fontSize: 30.0),
                decoration: InputDecoration(
                    hintText: '테마 설명을 적어주세요', border: OutlineInputBorder()),
              )),
            ],
          )
        ],
      ),
    ));
  }
}
