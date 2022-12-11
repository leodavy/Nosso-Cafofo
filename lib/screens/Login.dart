import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/colors_util.dart';
import '../utils/widgets_util.dart';
import 'Register.dart';


class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: hexStringToColor("#A5c9CA"),
        child: ListView(children: <Widget>[
          imgWidget("assets/images/Icone.png", 180, 180),
          SizedBox(height: 40), //para separar iconece das lacunas email/senha
          SizedBox(
            height: 30,
            child: reusableTextField("E-mail", false, TextEditingController()),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 30,
            child: reusableTextField("Senha", true, TextEditingController()),
          ),
          Container(
              height: 40,
              alignment: Alignment.center,
              child: TextButton(
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                    fontSize: 20,
                  )), // Style form

                  onPressed: () {
                    Navigator.pushNamed(context, "/ForgotPassword");
                  },
                  child: Text(
                    "Esqueceu a senha?",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                        color: Colors.black),
                  ))),
          //SizedBox(height: 5),
          Container(
              height: 40,
              alignment: Alignment.center,
              child: TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.pushNamed(context, "/Register");
                },
                child: Text(
                  "Registre - se",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      decoration: TextDecoration.underline),
                ),
              ))
        ]),
      ),
    );

  }


