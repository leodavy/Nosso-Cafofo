import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nosso_cafofo/utils/widgets_util.dart';
import 'package:path/path.dart';

import '../utils/colors_util.dart';

class Residents extends StatefulWidget {
  Residents({Key? key}) : super(key: key);

  _ResidentState createState() => _ResidentState();
}

class _ResidentState extends State<Residents> {
  var user = FirebaseAuth.instance.currentUser;
  var userDoc = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.email.toString());
  var cafofoPkey;
  List<String> residents = [''];
  bool first = true;

  get() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email.toString())
        .get()
        .then((value) {
      this.cafofoPkey = value['cafofo'];
      FirebaseFirestore.instance
          .collection('cafofos')
          .doc(value['cafofo'].toString())
          .get()
          .then((data) {
        this.residents = List.from(data['members']);
      });
    });

    setState(() {});
  }

  test() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      get();
      first = false;
      setState(() {});
    }
    return Scaffold(
        backgroundColor: hexStringToColor("#A5c9CA"),
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              child: AppBar(
                  iconTheme: IconThemeData(color: hexStringToColor("#2C3333")),
                  title: Text("Moradores",
                      style: TextStyle(color: hexStringToColor("#2C3333"))),
                  centerTitle: true,
                  backgroundColor: hexStringToColor("#E7F6F2"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0)))),
            ),
          ),
        ),
        body: Center(
            child: getWidgets(context, this.residents, () {
          setState(() {});
        })));
  }
}

ListView getWidgets(var context, var members, Function setState) {
  final children = <Widget>[];
  for (int i = 0; i < members.length; i++) {
    children.add(SizedBox(
      height: MediaQuery.of(context).size.height * 0.01,
    ));
    children.add(generateWidget(context, members[i].toString(), setState));
  }
  return new ListView(
    padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * (0.15 / 2),
        MediaQuery.of(context).size.width * 0.01,
        MediaQuery.of(context).size.width * (0.15 / 2),
        MediaQuery.of(context).size.width * 0.01),
    children: children,
  );
}

Container generateWidget(var context, String userPkey, Function setState) {
  return new Container(
    width: MediaQuery.of(context).size.width * 0.75,
    height: MediaQuery.of(context).size.height * 0.08,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(MediaQuery.of(context).size.height)),
        color: hexStringToColor("#E7F6F2")),
    child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      SizedBox(
        width: 10,
      ),
      CircleAvatar(
        radius: 50,
        backgroundImage: getProfilePic(context, userPkey, setState).image,
      ),
      Text(
        getUserName(userPkey, setState),
        style: TextStyle(fontSize: 20),
      ),
      SizedBox(
        width: 10,
      )
    ]),
  );
}

Image getProfilePic(var context, String userPkey, Function setState) {
  String url = "";
  FirebaseFirestore.instance
      .collection('users')
      .doc(userPkey)
      .get()
      .then((value) {
    url = value['profilePic'];
    setState;
  });
  return url != ""
      ? imgLinkWidget(url, MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.width)
      : imgWidget("assets/images/WithoutProfilePic.png",
          MediaQuery.of(context).size.width, MediaQuery.of(context).size.width);
}

String getUserName(String userPkey, Function setState) {
  String userName = "";
  FirebaseFirestore.instance
      .collection('users')
      .doc(userPkey)
      .get()
      .then((value) {
    userName = value['name'];
    setState;
  });
  return userName;
}
