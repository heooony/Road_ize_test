import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:road_ize/utilities/bottom_navigation.dart';
import 'dart:io';

import 'package:road_ize/screens/map_screen.dart';

class IntroduceScreen extends StatefulWidget {
  @override
  _IntroduceScreenState createState() => _IntroduceScreenState();
}

class _IntroduceScreenState extends State<IntroduceScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _profileImageURL = "";
  File _image;
  User _user;
  String name;
  String introduce;
  final nameController = TextEditingController();
  final introController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _prepareService();
  }

  void _prepareService() {
    _user = _auth.currentUser;
  }

  void isEmpty() {
    if (nameController.text == '' || introController.text == '') {
      final snackBar = SnackBar(
          content: Text(
            '모든 항목을 작성했는지 확인하십시오',
            style: TextStyle(fontSize: 15.0),
          ),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ));
      scaffoldKey.currentState.showSnackBar(snackBar);
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavigation()));
    }
  }

  void _uploadImageToStorage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile == null) return;
    setState(() {
      _image = File(pickedFile.path);
    });

    Reference ref = _firebaseStorage.ref().child('profile/${_user.uid}');
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
        key: scaffoldKey,
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
                        backgroundColor: Color(0x4479D26C),
                        backgroundImage:
                            (_image == null) ? null : FileImage(_image),
                        child: (_image == null)
                            ? Icon(
                                Icons.add_a_photo,
                                color: Color(0xFF79AA6C),
                              )
                            : Icon(
                                Icons.cached_sharp,
                                color: Color(0xFF79AA6C),
                              ),
                        radius: 60.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '이름 ',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        Expanded(
                            child: TextField(
                          controller: nameController,
                          style: TextStyle(fontSize: 30.0),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 3.0),
                              filled: true,
                              fillColor: Color(0x4479D26C),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)))),
                        )),
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
                            controller: introController,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: FlatButton(
                        onPressed: isEmpty,
                        child: Text('확인'),
                        color: Color(0x4479D26C),
                      ),
                    )
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
