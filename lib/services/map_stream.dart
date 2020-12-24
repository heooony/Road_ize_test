import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:road_ize/screens/thema_screen.dart';
import 'package:road_ize/utilities/firebase_information.dart';

class MapStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseInformation.firestore
            .collection('user_information')
            .doc(FirebaseInformation.user.uid)
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
            child: GridView.builder(
              itemCount: mapCards.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: mapCards[index],
                );
              },
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
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ThemaScreen(title: title, intro: intro)));
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
