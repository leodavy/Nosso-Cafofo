import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nosso_cafofo/screens/Register.dart';
import 'package:nosso_cafofo/screens/login.dart';
import 'package:nosso_cafofo/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(NossoCafofo());
}

  class NossoCafofo extends StatelessWidget{
    
    @override
    Widget build(BuildContext context){
      return MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/Splash",
    routes: {
      "/Splash": (context) => Splash(),
      '/login':(context) => Login(), 
      '/ForgotPassword':(context) => ForgotPassword()
    },
  );
}
  }