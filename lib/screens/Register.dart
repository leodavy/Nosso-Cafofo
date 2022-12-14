import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:nosso_cafofo/screens/Profile.dart';
import 'package:nosso_cafofo/utils/colors_util.dart';

import '../utils/widgets_util.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController =
      TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  Widget _incorrectPassword = SizedBox();

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
              child: reusableTextField("Nome", false, _nameTextController),
            ),
            SizedBox(height: 20), //Spacer
            SizedBox(
                height: 30,
                child:
                    reusableTextField("E-mail", false, _emailTextController)),
            SizedBox(height: 20), //Spacer
            SizedBox(
              height: 30,
              child: reusableTextField("Senha", true, _passwordTextController),
            ),
            SizedBox(height: 20), //Spacer
            SizedBox(
              height: 30,
              child: reusableTextField(
                  "Confirmar senha", true, _confirmPasswordTextController),
            ),
            SizedBox(height: 10),
            _incorrectPassword,

            SizedBox(
              height: 15,
            ),
            signInAndUpButton(context, false, () {
              if (_confirmPasswordTextController.text ==
                  _passwordTextController) {
                _incorrectPassword = SizedBox();
                setState(() {});
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) {
                  print("Created new acount");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });
              } else {
                _incorrectPassword = incorrectPassword();
                setState(() {});
              }
            })
          ]),
        )),
      ),
    );
  }

  Text incorrectPassword() {
    return Text(
      "Senhas não coincidem",
      style: TextStyle(color: hexStringToColor("#2c3333")),
    );
  }
}
