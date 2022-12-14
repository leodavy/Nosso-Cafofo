import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nosso_cafofo/screens/ForgotPassword.dart';

import '../utils/colors_util.dart';
import '../utils/widgets_util.dart';
import 'Register.dart';
import "Profile.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  Widget _errorWidget = SizedBox();

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
            child: reusableTextField("E-mail", false, _emailTextController),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 30,
            child: reusableTextField("Senha", true, _passwordTextController),
          ),
          SizedBox(
            height: 15,
          ),
          _errorWidget,
          SizedBox(height: 20),
          signInAndUpButton(context, true, () {
            FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text)
                .then((value) {
              print("Signed in");
              Navigator.pushNamed(context, "/Profile");
            }).onError((error, stackTrace) {
              print("incorrect Password");
              _errorWidget = incorrectPassword();
              setState(() {});
            });
          }),

          signUpOption()
        ]),
      ),
    );
  }

  Row incorrectPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("E-mail ou senha incorretos, ",
            style: TextStyle(color: hexStringToColor("#2c3333"))),
        GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ForgotPassword()));
            },
            child: Text(
              "Esqueceu sua senha?",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: hexStringToColor("#252B2B"),
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Não possui uma conta? ",
            style: TextStyle(color: hexStringToColor("#2c3333"))),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Register()));
          },
          child: Text(
            "Registre-se",
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: hexStringToColor("#252B2B"),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
