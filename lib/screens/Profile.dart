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
import 'package:nosso_cafofo/utils/externalAuth.dart';
import 'package:nosso_cafofo/utils/userManagement.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import '../utils/colors_util.dart';
import 'Notifications.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String profilePic = '';
  String userName = '';

  updateUserData() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.email)
          .get()
          .then((value) {
        profilePic = value['profilePic'];
        userName = value['name'];
      });
    }
  }

  uploadProfilePic() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;

    await Permission.photos.request();

    if (await (Permission.photos.status).isGranted) {
      image = (await _imagePicker.pickImage(source: ImageSource.gallery))
          as PickedFile;

      File? file = File(image.path);

      if (image != null) {
        final firebaseUser = await FirebaseAuth.instance.currentUser;
        String userPkey = firebaseUser!.email.toString();
        if (userPkey == null) {
          return;
        }
        var snapshot = await _firebaseStorage
            .ref()
            .child("$userPkey/profilePic")
            .putFile(file);
        var downloadURL = await snapshot.ref.getDownloadURL();
        userManagement().set('profilePic', downloadURL);
      }
    }
  }

  File? file;
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    updateUserData();
    return Scaffold(
        backgroundColor: hexStringToColor("#A5c9CA"),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width / 1.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: hexStringToColor("#E7F6F2")),
                  child: TextField(
                    selectionWidthStyle: BoxWidthStyle.tight,
                    textAlign: TextAlign.center,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                        hintText: "Alterar Nome",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25))),
                  )),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  uploadProfilePic();
                },
                child: CircleAvatar(
                  backgroundColor: hexStringToColor("#395B64"),
                  radius: 100,
                  child: CircleAvatar(
                    radius: 95,
                    backgroundImage:
                        profilePic != '' ? NetworkImage(profilePic) : null,
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
                      backgroundColor: hexStringToColor("#E7F6F2"),
                      foregroundColor: hexStringToColor("#2C3333")),
                  onPressed: () {
                    Navigator.pushNamed(context, "/ForgotPassword");
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
                      backgroundColor: hexStringToColor("#E7F6F2"),
                      foregroundColor: hexStringToColor("#2C3333")),
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
                      backgroundColor: hexStringToColor("#E7F6F2"),
                      foregroundColor: hexStringToColor("#2C3333")),
                  onPressed: () {
                    userManagement().set('name', _textEditingController.text);
                    updateUserData();
                  },
                  child:
                      Text("Salvar alterações", style: TextStyle(fontSize: 20)),
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height / 30,
                  width: MediaQuery.of(context).size.width / 3,
                  child: TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        print("Signed out");
                        Navigator.restorablePushNamed(context, "/login");
                      });
                    },
                    style: TextButton.styleFrom(
                      alignment: Alignment.center,
                    ),
                    child: Text("Desconectar",
                        style: TextStyle(
                            color: hexStringToColor("#2C3333"),
                            decoration: TextDecoration.underline,
                            fontSize: 15)),
                  )),
            ],
          ),
        ));
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
