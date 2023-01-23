import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nosso_cafofo/screens/Cafofo.dart';
import 'package:nosso_cafofo/screens/Login.dart';
import 'package:nosso_cafofo/utils/externalAuth.dart';
import 'package:nosso_cafofo/utils/UserManagement.dart';
import 'package:nosso_cafofo/utils/widgets_util.dart';
import 'package:path/path.dart';

import '../utils/colors_util.dart';
import 'Notifications.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool firstTry = true;
  var user = FirebaseAuth.instance.currentUser;
  String url = "";
  String userName = "";
  File? file;

  TextEditingController _textEditingController = TextEditingController();

  chooseImage() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    print("file " + xfile!.path);
    file = File(xfile.path);
  }

  updateProfile(BuildContext context) async {
    Map<String, dynamic> map = Map();
    if (file != null) {
      this.url = await uploadImage();
      map['profilePic'] = url;
    }
    if (_textEditingController.text != '') {
      map['name'] = _textEditingController.text;
      get();
    }

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .update(map);
    get();
  }

  Future<String> uploadImage() async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("${user?.email.toString()}")
        .child("profilePic")
        .putFile(file!);

    return taskSnapshot.ref.getDownloadURL();
  }

  get() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email.toString())
        .get()
        .then((value) {
      this.url = value['profilePic'];
      this.userName = value['name'];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (url == "" && firstTry) {
      get();
      firstTry = false;
    }

    bool textcenter = true;
    return Scaffold(
        backgroundColor: hexStringToColor("#A5c9CA"),
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: SafeArea(
                child: Container(
                    child: AppBar(
                        automaticallyImplyLeading: false,
                        title: Text("Perfil",
                            style:
                                TextStyle(color: hexStringToColor("#2C3333"))),
                        centerTitle: textcenter,
                        backgroundColor: hexStringToColor("#E7F6F2"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25.0),
                                bottomRight: Radius.circular(25.0))))))),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height / 25,
                  width: MediaQuery.of(context).size.width / 1.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: hexStringToColor("#395B64")),
                  child: TextField(
                    selectionWidthStyle: BoxWidthStyle.tight,
                    textAlign: TextAlign.center,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: userName,
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25))),
                  )),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  chooseImage();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey[700],
                  radius: 100,
                  child: CircleAvatar(
                    radius: 95,
                    backgroundImage: url != ''
                        ? imgLinkWidget(
                                url,
                                MediaQuery.of(context).size.width * 0.15,
                                MediaQuery.of(context).size.width * 0.15)
                            .image
                        : imgWidget(
                                "assets/images/WithoutProfilePic.png",
                                MediaQuery.of(context).size.width * 0.15,
                                MediaQuery.of(context).size.width * 0.15)
                            .image,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 110,
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 30),
              Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 1.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      backgroundColor: hexStringToColor("#395B64"),
                      foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, "/ChangeEmail");
                  },
                  child: Text("Alterar e-mail", style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 150,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 1.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      backgroundColor: hexStringToColor("#395B64"),
                      foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, "/ForgotPassword");
                  },
                  child: Text("Alterar senha", style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 1.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      backgroundColor: hexStringToColor("#395B64"),
                      foregroundColor: Colors.white),
                  onPressed: () {
                    updateProfile(context);
                    setState(() {});
                  },
                  child:
                      Text("Salvar alterações", style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height / 30,
                width: MediaQuery.of(context).size.width / 3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      backgroundColor: hexStringToColor("#395B64"),
                      foregroundColor: Colors.white),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      print("Signed out");
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Login()));
                    });
                  },
                  child: Text("Desconectar", style: TextStyle(fontSize: 15)),
                ),
              ),
            ])));
  }
}

class BotNavBar extends StatefulWidget {
  const BotNavBar({Key? key}) : super(key: key);

  @override
  _BotNavBarState createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int _currentindex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentindex,
          onTap: (index) {
            setState(() {
              _currentindex = index;
            });
          },
          unselectedFontSize: 13,
          selectedFontSize: 13,
          type: BottomNavigationBarType.fixed,
          backgroundColor: hexStringToColor("#E7F6F2"),
          selectedItemColor: hexStringToColor("#A5c9CA"),
          unselectedItemColor: hexStringToColor("#2C3333"),
          iconSize: 26,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notificações'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Cafofo'),
          ]),
      body: IndexedStack(
        index: _currentindex,
        children: <Widget>[Notifications(), Profile(), Cafofo()],
      ),
    );
  }
}
