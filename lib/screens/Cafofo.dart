import 'package:flutter/material.dart';

import '../utils/colors_util.dart';

class Cafofo extends StatefulWidget {
  const Cafofo({Key? key}) : super(key: key);

  @override
  State<Cafofo> createState() => _CafofoState();
}

class _CafofoState extends State<Cafofo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Text("Cafofo"),
        backgroundColor: hexStringToColor("#A5c9CA"),
      ),
    );
  }
}
