import 'package:flutter/material.dart';

import '../utils/colors_util.dart';

class Cafofo extends StatelessWidget {
  const Cafofo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
            backgroundColor: hexStringToColor("#A5c9CA"),
            body: Stack(children: <Widget>[
              Positioned(
                left: MediaQuery.of(context).size.width / 4,
                width: MediaQuery.of(context).size.width / 2,
                top: MediaQuery.of(context).size.height / 50,
                child: Row(children: <Widget>[
                  Container(),
                ]),
              )
            ])));
  }
}
