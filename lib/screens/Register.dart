import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:nosso_cafofo/utils/colors_util.dart';

import '../utils/widgets_util.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //TextEditingController _passwordTextController = ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: hexStringToColor("#A5c9CA"),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.fromLTRB(
              (MediaQuery.of(context).size.width * 0.1),
              (MediaQuery.of(context).size.height * 0.1),
              (MediaQuery.of(context).size.width * 0.1),
              0),
          child: Column(children: <Widget>[
            imgWidget("assets/images/Icone.png", 180, 180),
            SizedBox(height: 40), //Spacer
            SizedBox(
              height: 30,
              child: reusableTextField("Nome", false, TextEditingController()),
            ),
            SizedBox(height: 20), //Spacer
            SizedBox(
                height: 30,
                child: reusableTextField(
                    "E-mail", false, TextEditingController())),
            SizedBox(height: 20), //Spacer
            SizedBox(
              height: 30,
              child: reusableTextField("Senha", true, TextEditingController()),
            ),
            SizedBox(height: 20), //Spacer
            SizedBox(
              height: 30,
              child: reusableTextField(
                  "Confirmar senha", true, TextEditingController()),
            ),
          ]),
        )),
      ),
    );
  }
}
