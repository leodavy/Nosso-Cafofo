import 'package:flutter/material.dart';

import '../utils/colors_util.dart';

class Cafofo extends StatelessWidget {
  const Cafofo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool textcenter = true;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: SafeArea(
                child: Container(
                    child: AppBar(
                        automaticallyImplyLeading: false,
                        title: Text("Cafofo",
                            style:
                                TextStyle(color: hexStringToColor("#2C3333"))),
                        centerTitle: textcenter,
                        backgroundColor: hexStringToColor("#E7F6F2"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25.0),
                                bottomRight: Radius.circular(25.0))))))),
        backgroundColor: hexStringToColor("#A5c9CA"),
        body: Center(
            child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 32,
          runSpacing: 20,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                  color: hexStringToColor("#E7F6F2"),
                  borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/Shopping");
                },
                icon: Icon(Icons.shopping_cart, size: 100),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                  color: hexStringToColor("#E7F6F2"),
                  borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/Tasks");
                },
                icon: Icon(Icons.local_laundry_service, size: 100),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                  color: hexStringToColor("#E7F6F2"),
                  borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/Finances");
                },
                icon: Icon(Icons.monetization_on, size: 100),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                  color: hexStringToColor("#E7F6F2"),
                  borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/Residents");
                },
                icon: Icon(Icons.people, size: 100),
              ),
            )
          ],
        )));
  }
}
