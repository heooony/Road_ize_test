import 'package:cloud_firestore/cloud_firestore.dart';
import 'thema_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:road_ize/utilities/firebase_information.dart';

class ThemaScreen extends StatefulWidget {
  ThemaScreen({this.title, this.intro});
  final title;
  final intro;

  @override
  _ThemaScreenState createState() => _ThemaScreenState();
}

class _ThemaScreenState extends State<ThemaScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () {
                  FirebaseInformation.mapTitle = widget.title;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ThemaAddScreen()));
                })
          ],
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.black),
          ),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.black,
              );
            },
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: FirebaseInformation.firestore
                .collection('user_information')
                .doc(FirebaseInformation.user.uid)
                .collection('map_information')
                .doc(widget.title)
                .collection('branch_information')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text(
                    '지점이 없습니다.',
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }
              var branches = snapshot.data.docs;
              List<BranchList> branchList = [];
              for (var branch in branches) {
                var title = branch.data()['title'];
                var subtitle = branch.data()['intro'];
                var latitude = branch.data()['latitude'];
                var longitude = branch.data()['longitude'];
                var tile = BranchList(
                  title: title,
                  subtitle: subtitle,
                  latitude: latitude,
                  longitude: longitude,
                );
                branchList.add(tile);
              }
              return ListView(
                children: branchList,
              );
            }));
  }
}

class BranchList extends StatelessWidget {
  BranchList({this.title, this.subtitle, this.latitude, this.longitude});
  final title;
  final subtitle;
  final latitude;
  final longitude;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.where_to_vote_sharp),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: GestureDetector(
          onTap: () {
            FirebaseInformation.deleteThema(title);
          },
          child: Icon(Icons.restore_from_trash)),
    );
  }
}
