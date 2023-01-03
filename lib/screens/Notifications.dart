import 'package:flutter/material.dart';

import '../utils/colors_util.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: hexStringToColor("#A5c9CA"),
        body: Center(child: Text("Notificações")));
  }
}
