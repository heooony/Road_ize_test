import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FirebaseInformation {
  static final firestore = FirebaseFirestore.instance;
  static final firestorage = FirebaseStorage.instance;
  static final auth = FirebaseAuth.instance;
  static final User user = auth.currentUser;
  static File image;

  static void storeSetData(String collection, String data, String data2) {
    firestore
        .collection(collection)
        .doc(FirebaseInformation.user.uid)
        .set({'name': data, 'intro': data2});
  }

  static Future<String> storeGetData(String collection, String dataName) async {
    String data;
    await firestore
        .collection(collection)
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot document) {
      data = document[dataName];
    });
    return data;
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
}
