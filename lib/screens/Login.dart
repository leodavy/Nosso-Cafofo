import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Register.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.blueGrey[600],
        child: ListView(children: <Widget>[
          SizedBox(
            width: 128,
            height: 128,
            child: Image.asset("assets/images/Login/Icone.png"),
          ),
          SizedBox(width: 20), //para separar iconece das lacunas email/senha
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: "E-mail: ",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )),
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
                labelText: "senha: ",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )),
            style: TextStyle(fontSize: 20),
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
                  )))
        ]),
      ),
    );
  }
}
