
import 'package:flutter/material.dart';
import 'package:nosso_cafofo/login.dart';
import 'package:nosso_cafofo/splash.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => Splash(),
      '/login':(context) => Login(), 
      //'/Register':(context) => Register()
    },
  ));
}
