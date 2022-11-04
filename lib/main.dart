import 'package:flutter/material.dart';
import 'package:nosso_cafofo/screens/login.dart';
import 'package:nosso_cafofo/screens/splash.dart';

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