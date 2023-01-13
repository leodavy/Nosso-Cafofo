import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nosso_cafofo/screens/ChangeEmail.dart';
import 'package:nosso_cafofo/screens/Finances.dart';
import 'package:nosso_cafofo/screens/ForgotPassword.dart';
import 'package:nosso_cafofo/screens/Notifications.dart';
import 'package:nosso_cafofo/screens/Profile.dart';
import 'package:nosso_cafofo/screens/Register.dart';
import 'package:nosso_cafofo/screens/Login.dart';
import 'package:nosso_cafofo/screens/Residents.dart';
import 'package:nosso_cafofo/screens/Shopping.dart';
import 'package:nosso_cafofo/screens/Splash.dart';

import 'package:nosso_cafofo/screens/Cafofo.dart';
import 'package:nosso_cafofo/screens/Tasks.dart';

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
      initialRoute: "/Splash",
      routes: {
        "/Splash": (context) => Splash(),
        '/login': (context) => Login(),
        '/ForgotPassword': (context) => ForgotPassword(),
        '/Register': (context) => Register(),
        '/Profile': (context) => BotNavBar(),
        "/Notifications": (context) => Notifications(),
        "/Cafofo": ((context) => Cafofo()),
        "/Shopping": ((context) => Shopping()),
        "/Finances": ((context) => Finances()),
        "/Tasks": ((context) => Tasks()),
        "/Residents": ((context) => Residents()),
        "/ChangeEmail": ((context) => ChangeEmail())
      },
    );
  }
}
