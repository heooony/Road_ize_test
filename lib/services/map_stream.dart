import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:road_ize/utilities/firebase_information.dart';

class MapStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseInformation.firestore
            .collection('map_information')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final mapInformation = snapshot.data.docs;
          List<MapCard> mapCards = [];
          for (var information in mapInformation) {
            final title = information.data()['title'];
            final intro = information.data()['intro'];
            final mapCard = MapCard(
              title: title,
              intro: intro,
            );
            mapCards.add(mapCard);
          }
          return Container(
            height: width / 3,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: mapCards,
            ),
          );
        });
  }
}

class MapCard extends StatelessWidget {
  MapCard({this.title, this.intro});
  final title;
  final intro;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Tap')));
      },
      child: Container(
        width: width / 3,
        height: width / 3,
        decoration: BoxDecoration(),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
