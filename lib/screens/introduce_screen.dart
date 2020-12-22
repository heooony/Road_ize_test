import 'package:flutter/material.dart';
import 'package:road_ize/utilities/bottom_navigation.dart';
import 'package:road_ize/utilities/constants.dart';
import 'package:road_ize/utilities/firebase_information.dart';
import 'package:road_ize/utilities/snackBar.dart';

class IntroduceScreen extends StatefulWidget {
  @override
  _IntroduceScreenState createState() => _IntroduceScreenState();
}

class _IntroduceScreenState extends State<IntroduceScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final nameController = TextEditingController();
  final introController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isInfo();
  }

  Future<void> isInfo() async {
    try {
      var whoAmI =
          await FirebaseInformation.getStoreData('user_information', 'name');
      if (whoAmI != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomNavigation()));
      }
    } catch (e) {
      return 'finish';
    }
  }

  void isEmpty() {
    if (nameController.text == '' || introController.text == '') {
      MySnackBar(scaffoldKey: scaffoldKey, text: '모든 항목을 입력해주십시오.')
          .snackBarUp();
    } else {
      FirebaseInformation.setStoreData(
          'user_information', nameController.text, introController.text);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavigation()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: isInfo(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Center(child: CircularProgressIndicator());
          } else {
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
                        width: screenWidth / 5 * 4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 7.0,
                              spreadRadius: 4.0,
                              offset: Offset(
                                  6.0, 6.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RawMaterialButton(
                              onPressed: FirebaseInformation.uploadFireStorage,
                              child: CircleAvatar(
                                backgroundColor: Color(0x4479D26C),
                                backgroundImage:
                                    (FirebaseInformation.image == null)
                                        ? null
                                        : FileImage(FirebaseInformation.image),
                                child: (FirebaseInformation.image == null)
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)))),
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
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 3.0),
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
        });
  }
}
