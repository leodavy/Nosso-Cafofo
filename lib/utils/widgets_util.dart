import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nosso_cafofo/utils/colors_util.dart';

Image imgWidget(String imagePath, double width, double height) {
  return Image.asset(
    imagePath,
    fit: BoxFit.contain,
    width: width,
    height: height,
  );
}

Image imgLinkWidget(String imageLink, double width, double height) {
  return Image.network(
    imageLink,
    fit: BoxFit.contain,
    width: width,
    height: height,
  );
}

TextField reusableTextField(String text, /*IconData icon,*/ bool isPassword,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    enableSuggestions: !isPassword,
    autocorrect: !isPassword,
    cursorColor: hexStringToColor("#2c3333"),
    style: TextStyle(color: hexStringToColor("#2c3333")),
    decoration: InputDecoration(
        /*prefixIcon: Icon(
          icon,
          color: (hexStringToColor("#e7f6f2").withOpacity(0.7)),
        ),*/
        labelText: text,
        labelStyle:
            TextStyle(color: hexStringToColor("#2c3333").withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: hexStringToColor("#e7f6f2").withOpacity(0.5),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none))),
    keyboardType:
        isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}

Container signInAndUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
    child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        child: Text(
          isLogin ? "Entrar" : "Registrar-se",
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
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
  );
}

Container externalSignIn(BuildContext context, String text, String imagePath,
    String color, String darkerColor, String textColor, Function onTap) {
  return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: ElevatedButton(
          onPressed: () {
            onTap();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              imgWidget(imagePath, MediaQuery.of(context).size.width * 0.10,
                  MediaQuery.of(context).size.height * 0.8),
              Text(
                text,
                style: TextStyle(
                    color: hexStringToColor(textColor),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              )
            ],
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
              ((states) {
                if (states.contains(MaterialState.pressed)) {
                  return hexStringToColor(darkerColor);
                }
                return hexStringToColor(color);
              }),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          )));
}
/*
MaterialButton(
            onPressed: () {
              _googleSignIn.signIn();
            },
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.1,
            minWidth: MediaQuery.of(context).size.width * 0.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                imgWidget(
                    "assets/images/Login/googleicon.png",
                    MediaQuery.of(context).size.width * 0.25,
                    MediaQuery.of(context).size.height * 0.1),
                Text(
                  "Entrar com Google",
                  style: TextStyle(
                      color: hexStringToColor("#2c3333"), fontSize: 14),
                )
              ],
            ),
          )*/
