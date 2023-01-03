import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nosso_cafofo/screens/Profile.dart';
import 'dart:io';

import '../utils/colors_util.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String imageUrl = " ";

  void pickUploadImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );

    Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");

    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      print(value);
      setState(() {
        imageUrl = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, "/Profile");
            },
          ),
        ),
        backgroundColor: hexStringToColor("#A5c9CA"),
        body: Stack(children: <Widget>[
          Positioned(
            left: MediaQuery.of(context).size.width / 4,
            width: MediaQuery.of(context).size.width / 2,
            top: MediaQuery.of(context).size.height / 50,
            child: Column(
              children: <Widget>[
                GestureDetector(onTap: () {
                  pickUploadImage();
                }),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 4.2,
                  alignment: Alignment.center,
                  child: Center(
                      child: imageUrl == " "
                          ? const CircleAvatar(
                              radius: 100,
                            )
                          : Image.network(imageUrl)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 15,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Alterar foto de perfil",
                        style: TextStyle(color: hexStringToColor("#2C3333")),
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: hexStringToColor("#E7F6F2"),
                  ),
                  child: SizedBox(child: Text("Nome")),
                )
              ],
            ),
          )
        ]));
  }
}
