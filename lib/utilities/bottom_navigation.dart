import 'package:road_ize/screens/map_screen.dart';
import 'package:road_ize/screens/add_screen.dart';
import 'package:road_ize/screens/feed_screen.dart';
import 'package:road_ize/screens/search_screen.dart';
import 'package:road_ize/screens/user_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  //variable
  int _currentIndex = 0;
  final pageController = PageController();

  //method
  void _onTap(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _children = [
    MapScreen(),
    SearchScreen(),
    AddScreen(),
    FeedScreen(),
    UserScreen()
  ];

  //main
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: _children,
          physics: NeverScrollableScrollPhysics(), // No sliding
        ),
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.greenAccent.shade700,
      currentIndex: _currentIndex,
      onTap: _onTap,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
        BottomNavigationBarItem(icon: Icon(Icons.wifi), label: 'Feed'),
        BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle), label: 'User'),
      ],
    );
  }
}
