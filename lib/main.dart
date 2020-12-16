import 'package:flutter/material.dart';
import 'package:road_ize/screens/map_screen.dart';
import 'package:road_ize/screens/add_screen.dart';
import 'package:road_ize/screens/feed_screen.dart';
import 'package:road_ize/screens/search_screen.dart';
import 'package:road_ize/screens/user_screen.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 5,
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Center(
                    child: Text(
                  'ROAD_IZE',
                  style: TextStyle(color: Colors.black),
                )),
                backgroundColor: Colors.white70,
              ),
              body: TabBarView(
                children: [
                  MapScreen(),
                  AddScreen(),
                  FeedScreen(),
                  SearchScreen(),
                  UserScreen()
                ],
              ),
              bottomNavigationBar: TabBar(
                indicatorColor: Colors.green.shade700,
                unselectedLabelColor: Colors.lightGreen.shade500,
                labelColor: Colors.lightGreen.shade800,
                tabs: [
                  TabButton(
                    icon: Icons.map,
                    text: '지도',
                  ),
                  TabButton(
                    icon: Icons.search,
                    text: '검색',
                  ),
                  TabButton(
                    icon: Icons.add,
                    text: '추가',
                  ),
                  TabButton(
                    icon: Icons.wifi,
                    text: '피드',
                  ),
                  TabButton(
                    icon: Icons.supervised_user_circle,
                    text: '내 정보',
                  ),
                ],
              ))),
    );
  }
}

class TabButton extends StatelessWidget {
  TabButton({this.icon, this.text});
  final icon;
  final text;

  @override
  Widget build(BuildContext context) {
    return Tab(
      iconMargin: EdgeInsets.only(bottom: 4),
      icon: Icon(
        icon,
        size: 30,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
