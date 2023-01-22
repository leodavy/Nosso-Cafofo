import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/colors_util.dart';

class Notifications extends StatefulWidget {
  Notifications({Key? key}) : super(key: key);

  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var user = FirebaseAuth.instance.currentUser;
  var userDoc = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.email.toString());
  var cafofoPkey;
  List<String> notifications = [''];
  bool first = true;

  get() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email.toString())
        .get()
        .then((value) {
      this.cafofoPkey = value['cafofo'];
      print(this.cafofoPkey);
    });

    FirebaseFirestore.instance
        .collection('cafofos')
        .doc(cafofoPkey.toString())
        .get()
        .then((value) {
      print(List.from(value['notifications'])[0]);
      this.notifications = List.from(value['notifications']);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      get();
      first = false;
      setState(() {});
    }
    if (this.cafofoPkey != '') {
      return Scaffold(
          appBar: PreferredSize(
              preferredSize: AppBar().preferredSize,
              child: SafeArea(
                  child: Container(
                      child: AppBar(
                          automaticallyImplyLeading: false,
                          title: Text("Notificações",
                              style: TextStyle(
                                  color: hexStringToColor("#2C3333"))),
                          centerTitle: true,
                          backgroundColor: hexStringToColor("#E7F6F2"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25.0),
                                  bottomRight: Radius.circular(25.0))))))),
          backgroundColor: hexStringToColor("#A5c9CA"),
          body: Center(child: getWidgets(context, this.notifications)));
    } else {
      return Scaffold(
          appBar: PreferredSize(
              preferredSize: AppBar().preferredSize,
              child: SafeArea(
                  child: Container(
                      child: AppBar(
                          automaticallyImplyLeading: false,
                          title: Text("Notificações",
                              style: TextStyle(
                                  color: hexStringToColor("#2C3333"))),
                          centerTitle: true,
                          backgroundColor: hexStringToColor("#E7F6F2"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25.0),
                                  bottomRight: Radius.circular(25.0))))))),
          backgroundColor: hexStringToColor("#A5c9CA"),
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(
                      MediaQuery.of(context).size.height * (0.08 / 3))),
                  color: hexStringToColor("#E7F6F2")),
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.01,
                  MediaQuery.of(context).size.width * 0.01,
                  MediaQuery.of(context).size.width * 0.01,
                  MediaQuery.of(context).size.width * 0.01),
              child: Center(
                  child: Text(
                      "Você precisa estar em um cafofo para receber notificações",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          color: hexStringToColor("#252B2B"),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center)),
            ),
          ));
    }
  }
}

ListView getWidgets(var context, var itens) {
  final children = <Widget>[];
  if (itens != null) {
    for (var i = 0; i < itens.length; i++) {
      if (itens[i] == '') continue;
      children.add(SizedBox(
        height: MediaQuery.of(context).size.height * 0.01,
      ));
      children.add(generateWidget(context, itens[i]));
    }
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

Container generateWidget(var context, String content) {
  return new Container(
    width: MediaQuery.of(context).size.width * 0.75,
    height: MediaQuery.of(context).size.height * 0.08,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(MediaQuery.of(context).size.height * (0.08 / 3))),
        color: hexStringToColor("#E7F6F2")),
    child: Center(
        child: Text(content,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.02,
                color: hexStringToColor("#252B2B"),
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center)),
  );
}
