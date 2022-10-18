import 'dart:async';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    startTimer();
    super.initState();
  }

  startTimer(){
    var duration = Duration(seconds: 2);
    return Timer(duration, route);
  }

  route(){
    Navigator.of(context).pushReplacementNamed('/login');
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[600],
      child: Container(
        child: Image.asset("assets/images/SplashScreen/SplashScreenIcon.png")),
    );
  }
}
