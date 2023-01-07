import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nosso_cafofo/screens/Profile.dart';
import 'dart:io';

import '../utils/colors_util.dart';
import '../utils/widgets_util.dart';

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
    TextEditingController _emailTextController = TextEditingController();
    bool textcenter = true;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              child: AppBar(
                  iconTheme: IconThemeData(color: hexStringToColor("#2C3333")),
                  title: Text("Editar Perfil",
                      style: TextStyle(color: hexStringToColor("#2C3333"))),
                  centerTitle: textcenter,
                  backgroundColor: hexStringToColor("#E7F6F2"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0)))),
            ),
          ),
        ),
        backgroundColor: hexStringToColor("#A5c9CA"),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  pickUploadImage();
                },
                child: CircleAvatar(
                  radius: 100,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width / 1.2,
                child: reusableTextField("E-mail", false, _emailTextController),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/ForgotPassword");
                  },
                  child: Text(
                    "Redefinir senha",
                    style: TextStyle(color: hexStringToColor("#2C3333")),
                  ))
            ],
          ),
        ));
  }
}
