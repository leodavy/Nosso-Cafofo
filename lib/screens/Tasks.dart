import 'package:flutter/material.dart';

import '../utils/colors_util.dart';

class Tasks extends StatelessWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool textcenter = true;

    return Scaffold(
        backgroundColor: hexStringToColor("#A5c9CA"),
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              child: AppBar(
                  title: Text("Tarefas",
                      style: TextStyle(color: hexStringToColor("#2C3333"))),
                  centerTitle: textcenter,
                  backgroundColor: hexStringToColor("#E7F6F2"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0)))),
            ),
          ),
        ),
        body: Center(child: Text("Moradores")));
  }
}
