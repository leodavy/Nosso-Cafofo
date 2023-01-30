import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nosso_cafofo/utils/UserManagement.dart';

import '../utils/colors_util.dart';
import '../utils/widgets_util.dart';

class Cafofo extends StatefulWidget {
  Cafofo({Key? key}) : super(key: key);

  _CafofoState createState() => _CafofoState();
}

class _CafofoState extends State<Cafofo> {
  var user = FirebaseAuth.instance.currentUser;
  var cafofoPkey;
  bool firstTry = true;

  TextEditingController _cafofoTextController = TextEditingController();
  var _errorWidget = SizedBox();
  get() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email.toString())
        .get()
        .then((value) {
      this.cafofoPkey = value['cafofo'];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (firstTry) {
      get();
      firstTry = false;
    }
    if (this.cafofoPkey != '') {
      bool textcenter = true;
      return Scaffold(
          appBar: PreferredSize(
              preferredSize: AppBar().preferredSize,
              child: SafeArea(
                  child: Container(
                      child: AppBar(
                          automaticallyImplyLeading: false,
                          title: Text("Cafofo",
                              style: TextStyle(
                                  color: hexStringToColor("#2C3333"))),
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
            alignment: WrapAlignment.spaceEvenly,
            spacing: 1,
            runSpacing: 15,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: hexStringToColor("#E7F6F2")),
                child: Text("Código do cafofo: \n${this.cafofoPkey.toString()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25)),
                height: MediaQuery.of(context).size.height / 14,
                width: MediaQuery.of(context).size.width / 1.2,
              ),
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
                  icon: Icon(Icons.shopping_cart,
                      color: hexStringToColor("#395B64"), size: 100),
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
                  icon: Icon(Icons.local_laundry_service,
                      color: hexStringToColor("#395B64"), size: 100),
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
                  icon: Icon(Icons.monetization_on,
                      color: hexStringToColor("#395B64"), size: 100),
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
                  icon: Icon(Icons.people,
                      color: hexStringToColor("#395B64"), size: 100),
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: hexStringToColor('#E7F6F2')),
                  child: TextButton(
                      onPressed: () async {
                        var userDoc = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user!.email);
                        await userDoc.get().then((value) async {
                          await FirebaseFirestore.instance
                              .collection('cafofos')
                              .doc(value['cafofo'])
                              .update({
                            'members': FieldValue.arrayRemove([user!.email])
                          });
                        });
                        await userDoc.update({'cafofo': ''});
                        get();
                        setState(() {});
                      },
                      child: Text(
                        "Sair do cafofo",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )))
            ],
          )));
    } else {
      return Scaffold(
          body: Container(
              padding: EdgeInsets.only(top: 60, left: 40, right: 40),
              //width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              color: hexStringToColor("#A5c9CA"),
              child: ListView(
                children: <Widget>[
                  Text("Você não está em nenhum cafofo!",
                      style: TextStyle(
                          fontSize: 20,
                          color: hexStringToColor("#252B2B"),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text("Crie um novo cafofo",
                      style: TextStyle(
                          fontSize: 18,
                          color: hexStringToColor("#252B2B"),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: ElevatedButton(
                        onPressed: () async {
                          String cafofoPkey;
                          do {
                            cafofoPkey = generateRandomString(8);
                          } while ((await FirebaseFirestore.instance
                                  .collection('cafofos')
                                  .doc(cafofoPkey)
                                  .get())
                              .exists);

                          UserManagement().set('cafofo', cafofoPkey);
                          FirebaseFirestore.instance
                              .collection('cafofos')
                              .doc(cafofoPkey)
                              .set(<String, dynamic>{
                            'members': [user!.email],
                            'finances': [],
                            'shopping': [],
                            'tasks': [],
                            'notifications': []
                          });
                          get();
                          setState(() {});
                        },
                        child: Text(
                          "Criar cafofo",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                              ((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return hexStringToColor("#17404C");
                                }
                                return hexStringToColor("#395b64");
                              }),
                            ),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))))),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    "Ou entre em um cafofo existente",
                    style: TextStyle(
                        fontSize: 18,
                        color: hexStringToColor("#252B2B"),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: reusableTextField(
                        "Código do cafofo", false, _cafofoTextController),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _errorWidget,
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: ElevatedButton(
                        onPressed: () async {
                          var cafofo = await FirebaseFirestore.instance
                              .collection('cafofos')
                              .doc(_cafofoTextController.text);
                          if ((await cafofo.get()).exists) {
                            cafofo.update({
                              'members': FieldValue.arrayUnion([user!.email])
                            });
                            UserManagement()
                                .set('cafofo', _cafofoTextController.text);
                            get();
                            setState(() {});
                          } else {
                            _errorWidget = SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                              child: Text(
                                "Código inválido",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: hexStringToColor("#252B2B"),
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                            setState(() {});
                          }
                        },
                        child: Text(
                          "Entrar",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                              ((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return hexStringToColor("#17404C");
                                }
                                return hexStringToColor("#395b64");
                              }),
                            ),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))))),
                  ),
                ],
              )));
    }
  }

  String generateRandomString(int len) {
    var r = Random.secure();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
