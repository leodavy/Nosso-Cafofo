import 'package:flutter/material.dart';

import '../utils/colors_util.dart';

class Finances extends StatelessWidget {
  const Finances({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: hexStringToColor("#A5c9CA"),
        body: Center(child: Text("Finanças")));
  }
}
