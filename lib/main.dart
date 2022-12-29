import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nosso_cafofo/screens/ForgotPassword.dart';
import 'package:nosso_cafofo/screens/Notifications.dart';
import 'package:nosso_cafofo/screens/Profile.dart';
import 'package:nosso_cafofo/screens/Register.dart';
import 'package:nosso_cafofo/screens/Login.dart';
import 'package:nosso_cafofo/screens/Splash.dart';
import 'package:nosso_cafofo/screens/ModifyProfile.dart';
import 'package:nosso_cafofo/screens/Cafofo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(NossoCafofo());
}

class NossoCafofo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/Profile",
      routes: {
        "/Splash": (context) => Splash(),
        '/login': (context) => Login(),
        '/ForgotPassword': (context) => ForgotPassword(),
        '/Register': (context) => Register(),
        '/Profile': (context) => Profile(),
        "/ModifyProfile": (context) => ModifyProfile(),
        "/Notifications": (context) => Notifications(),
        "/Cafofo": ((context) => Cafofo()),
      },
    );
  }
}
