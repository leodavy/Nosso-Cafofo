import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:nosso_cafofo/utils/colors_util.dart';
import '../utils/widgets_util.dart';
import '../utils/UserManagement.dart';

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
              if (_passwordTextController.text
                      .compareTo(_confirmPasswordTextController.text) ==
                  0) {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) {
                  print("Created new acount");
                  UserManagement().storeNewUser(
                      value.user, _nameTextController.text, null, context);
                }).onError((error, stackTrace) {
                  if(error.toString() == '[firebase_auth/weak-password] Password should be at least 6 characters'){
                    _incorrectPassword = invalidPassword();
                    setState(() {
                    });
                  }
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

  Text invalidPassword(){
    return Text(
      "Senha deve possuir no mínimo, 6 caracteres",
      style: TextStyle(color: hexStringToColor("#2c3333")),
    );
  }
}
