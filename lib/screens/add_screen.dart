import 'package:road_ize/utilities/firebase_information.dart';
import 'package:road_ize/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final titleController = TextEditingController();
  final introController = TextEditingController();
  String title = '';
  String intro = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = width - 40.0;
    return Scaffold(
      backgroundColor: mainColor1,
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 80.0, horizontal: 20.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: titleController,
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'TITLE'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: introController,
                  onChanged: (value) {
                    intro = value;
                  },
                  maxLines: 3,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'INTRODUCE'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: width,
                  height: height,
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 50.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 1.3),
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  onPressed: () async {
                    await FirebaseInformation.createThema(
                            scaffoldKey, title, intro)
                        .then((value) {
                      if (value == 0) {
                        titleController.clear();
                        introController.clear();
                      }
                    });
                  },
                  child: Text(
                    '생성',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  color: subColor2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Palette extends StatelessWidget {
  List<Color> colorList = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.blueAccent,
    Colors.purple
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: GestureDetector(
          onTap: () {},
          child: Container(
            height: 20.0,
            color: colorList[0],
          ),
        ))
      ],
    );
  }
}
