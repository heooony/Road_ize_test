import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:road_ize/utilities/firebase_information.dart';

class UserStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseInformation.firestore
          .collection('user_information')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {}
        FirebaseInformation.firestore
            .collection('user_information')
            .doc(FirebaseInformation.user.uid)
            .get()
            .then((value) {
          print('@@@@@@@@@@@@@@@@@@@$value');
        });

        return;
      },
    );
  }
}
