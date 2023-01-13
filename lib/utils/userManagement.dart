import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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
            context, MaterialPageRoute(builder: (context) => BotNavBar())))
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
}
