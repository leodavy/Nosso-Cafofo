import 'package:flutter/material.dart';

import '../utils/colors_util.dart';

class Residents extends StatelessWidget {
  const Residents({Key? key}) : super(key: key);

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
                  iconTheme: IconThemeData(color: hexStringToColor("#2C3333")),
                  title: Text("Moradores",
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
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 25),
            Container(
                height: MediaQuery.of(context).size.height / 14,
                width: MediaQuery.of(context).size.width / 1.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: hexStringToColor("#E7F6F2"),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 20),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Morador 1",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                )),
            SizedBox(height: 25),
            Container(
                height: MediaQuery.of(context).size.height / 14,
                width: MediaQuery.of(context).size.width / 1.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: hexStringToColor("#E7F6F2"),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 20),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Morador 2",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                )),
            SizedBox(height: 25),
          ],
        )));
  }
}
