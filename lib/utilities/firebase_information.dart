import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:road_ize/services/user_stream.dart';
import 'snackBar.dart';
import 'dart:io';

class FirebaseInformation {
  static Future<void> themaCount =
      FirebaseInformation.getStoreData('user_information', 'themaCount');
  static Future<void> branchCount =
      FirebaseInformation.getStoreData('user_information', 'brunchCount');
  static final firestore = FirebaseFirestore.instance;
  static final firestorage = FirebaseStorage.instance;
  static final auth = FirebaseAuth.instance;
  static User user = auth.currentUser;
  static File image;
  static String mapTitle;

  static void setStoreData(String collection, String data, String data2) {
    firestore
        .collection(collection)
        .doc(FirebaseInformation.user.uid)
        .set({'name': data, 'intro': data2});
  }

  static Future<String> getStoreData(collection, dataName) async {
    String data;
    await firestore
        .collection(collection)
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot document) {
      data = document[dataName];
    });
    if (data != null)
      return data;
    else
      return null;
  }

  static void signOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      user = auth.currentUser;
    });
  }

  static void uploadFireStorage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    image = File(pickedFile.path);
    Reference ref = firestorage.ref().child('profile/${user.uid}');
    UploadTask uploadTask = ref.putFile(image);
    uploadTask.then((res) {
      String url = res.ref.getDownloadURL().toString();
      return url;
    });
  }

  static void uploadThema(String title, String intro) async {
    await FirebaseInformation.firestore
        .collection('user_information')
        .doc(FirebaseInformation.user.uid)
        .collection('map_information')
        .doc(FirebaseInformation.mapTitle)
        .collection('branch_information')
        .doc(title)
        .set({'title': title, 'intro': intro});
  }

  static void deleteThema(String title) async {
    await FirebaseInformation.firestore
        .collection('user_information')
        .doc(FirebaseInformation.user.uid)
        .collection('map_information')
        .doc(FirebaseInformation.mapTitle)
        .collection('branch_information')
        .doc(title)
        .delete();
  }

  static Future<int> createThema(scaffoldKey, title, intro) async {
    var doit = await FirebaseInformation.firestore
        .collection('user_information')
        .doc(FirebaseInformation.user.uid)
        .collection('map_information')
        .doc(title)
        .get()
        .then((value) async {
      if (value.data() == null) {
        await FirebaseInformation.firestore
            .collection('user_information')
            .doc(FirebaseInformation.user.uid)
            .collection('map_information')
            .doc(title)
            .set({'title': title, 'intro': intro});
        return 0;
      } else {
        MySnackBar(scaffoldKey: scaffoldKey, text: '해당 제목이 존재합니다.')
            .snackBarUp();
        return 1;
      }
    });
    if (doit == 0)
      return 0;
    else
      return 1;
  }
}
