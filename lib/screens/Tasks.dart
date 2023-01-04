import 'package:flutter/material.dart';

import '../utils/colors_util.dart';

class Tasks extends StatelessWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: hexStringToColor("#A5c9CA"),
        body: Center(child: Text("Tarefas")));
  }
}
