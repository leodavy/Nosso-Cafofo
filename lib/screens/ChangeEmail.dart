import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nosso_cafofo/utils/userManagement.dart';

import '../utils/colors_util.dart';
import '../utils/widgets_util.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({super.key});

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  TextEditingController _emailTextController = TextEditingController();

  Widget _errorWidget = SizedBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: 60, left: 40, right: 40),
      //width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height,
      color: hexStringToColor("#A5c9CA"),
      child: ListView(
        children: <Widget>[
          imgWidget("assets/images/LOGOCAFOFONOME.png", 180, 180),
          SizedBox(height: 10),
          Text("Insira o seu novo endereço de e-mail: ",
              style: TextStyle(
                  color: hexStringToColor("#252B2B"),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          SizedBox(height: 40),
          SizedBox(
            height: 30,
            width: MediaQuery.of(context).size.width * 0.50,
            child: reusableTextField(
                "Endereço de E-mail", false, _emailTextController),
          ),
          SizedBox(
            height: 10,
          ),
          _errorWidget,
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: 50,
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ElevatedButton(
                onPressed: () {
                  userManagement().set('email', _emailTextController.text);
                  FirebaseAuth.instance.currentUser
                      ?.updateEmail(_emailTextController.text);
                },
                child: Text(
                  "Enviar",
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
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))))),
          ),
        ],
      ),
    ));
  }

  Row incorrectEmail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("E-mail incorreto ou não cadastrado",
            style: TextStyle(
                color: hexStringToColor("#252B2B"),
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
