import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../screens/Profile.dart';

class userManagement {
  storeNewUser(user, userName, profilePic, context) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser?.email)
        .set({
          'email': user.email,
          'name': userName,
          'profilePic': profilePic ?? ''
        })
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profile())))
        .catchError((e) {
          print(e);
        });
  }

  get(String field) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.email)
          .get()
          .then((table) {
        return table.data()![field];
      }).catchError((e) {
        print(e);
      });
    }
  }

  set(String field, value) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.email)
          .set({field: value}).catchError((e) {
        print(e);
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
        String userPkey = get('email');
        var snapshot = await _firebaseStorage
            .ref()
            .child("$userPkey/profilePic")
            .putFile(file);
        var downloadURL = await snapshot.ref.getDownloadURL();
        set('profilePic', downloadURL);
      }
    }
  }
}
