import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
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
                      '김동헌',
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
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                    '안녕하세요~!~! 이 앱을 개발하고 있는 개발 0개월차 김동헌이라고 합니다. 만나서 반갑습니다. 별거는 없지만 그냥 둘러만 봐주세요',
                    style: TextStyle(fontSize: 20.0))
              ],
            ),
          ),
          Container()
        ],
      ),
    );
  }
}
