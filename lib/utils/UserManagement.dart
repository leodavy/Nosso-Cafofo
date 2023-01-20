import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../screens/Profile.dart';

class UserManagement {
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
    var dataToRecive;
    if (firebaseUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.email.toString())
          .get()
          .then((value) {
        dataToRecive = value[field];
      });
      return dataToRecive.toString();
      /*await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.email)
          .get()
          .then((table) {
        return table.data()![field].toString();
      }).catchError((e) {
        print(e);
      });*/
    }
  }

  set(String field, value) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.email)
          .update({field: value}).catchError((e) {
        print(e);
      });
    }
  }
}
