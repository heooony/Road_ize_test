import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class IntroduceScreen extends StatefulWidget {
  @override
  _IntroduceScreenState createState() => _IntroduceScreenState();
}

class _IntroduceScreenState extends State<IntroduceScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String _profileImageURL = "";
  File _image;
  User _user;
  String name;
  String introduce;
  String image;

  @override
  void initState() {
    super.initState();
    _prepareService();
  }

  void _prepareService() {
    _user = _auth.currentUser;
  }

  void _uploadImageToStorage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile == null) return;
    setState(() {
      _image = File(pickedFile.path);
    });

    Reference ref =
        _firebaseStorage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image);
    uploadTask.then((res) {
      String url = res.ref.getDownloadURL().toString();
      _profileImageURL = url;
      return url;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF79D26C),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'INFORMATION',
                style: TextStyle(fontSize: 40.0, color: Colors.white),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                width: width / 5 * 4,
                height: height / 5 * 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 7.0,
                      spreadRadius: 4.0,
                      offset:
                          Offset(6.0, 6.0), // shadow direction: bottom right
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RawMaterialButton(
                      onPressed: _uploadImageToStorage,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(_profileImageURL),
                        child: Icon(
                          Icons.add_a_photo,
                          color: Color(0xFF79AA6C),
                        ),
                        radius: 60.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '이름 ',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        SizedBox(
                          height: 30.0,
                          width: 100.0,
                          child: TextField(
                            style: TextStyle(fontSize: 30.0),
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 3.0),
                                filled: true,
                                fillColor: Color(0x4479D26C),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0)))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '소개 ',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        Expanded(
                          child: TextField(
                            style: TextStyle(fontSize: 30.0),
                            maxLines: 3,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 3.0),
                                filled: true,
                                fillColor: Color(0x4479D26C),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0)))),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// StreamBuilder<QuerySnapshot>(
// stream: _firestore.collection('user_information').snapshots(),
// builder: (context, snapshot) {
// _firestore
//     .collection('map_information')
//     .add({'title': title, 'intro': intro});
// return;
// }
