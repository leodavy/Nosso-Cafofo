import 'package:flutter/material.dart';

import '../utils/colors_util.dart';

class Cafofo extends StatelessWidget {
  const Cafofo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: hexStringToColor("#A5c9CA"),
        body: Stack(children: <Widget>[
          Positioned(
            left: MediaQuery.of(context).size.width / 20,
            width: MediaQuery.of(context).size.width / 3,
            top: MediaQuery.of(context).size.height / 3,
            child: Container(
              height: MediaQuery.of(context).size.height / 7,
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                  color: hexStringToColor("#E7F6F2"),
                  borderRadius: BorderRadius.circular(50)),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: hexStringToColor("#E7F6F2")),
                label: Text("Compras"),
                icon: Icon(
                    size: 100,
                    Icons.shopping_cart,
                    color: hexStringToColor("2C3333")),
                onPressed: () {
                  Navigator.pushNamed(context, "/Shopping");
                },
              ),
            ),
          ),
          Positioned(
              left: MediaQuery.of(context).size.width / 20,
              width: MediaQuery.of(context).size.width / 2,
              top: MediaQuery.of(context).size.height / 2,
              child: Container(
                height: MediaQuery.of(context).size.height / 7,
                width: MediaQuery.of(context).size.width / 4,
                decoration: BoxDecoration(
                    color: hexStringToColor("#E7F6F2"),
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: hexStringToColor("#E7F6F2")),
                  icon: Icon(
                      size: 100,
                      Icons.wallet,
                      color: hexStringToColor("2C3333")),
                  onPressed: () {
                    Navigator.pushNamed(context, "/Finances");
                  },
                ),
              )),
          Positioned(
              left: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2,
              top: MediaQuery.of(context).size.height / 3,
              child: Container(
                height: MediaQuery.of(context).size.height / 8,
                width: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    color: hexStringToColor("#E7F6F2"),
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: hexStringToColor("#E7F6F2")),
                  icon: Icon(
                      size: 100,
                      Icons.cleaning_services_sharp,
                      color: hexStringToColor("2C3333")),
                  onPressed: () {
                    Navigator.pushNamed(context, "/Tasks");
                  },
                ),
              ))
        ]));
  }
}
