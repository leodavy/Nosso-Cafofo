import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:nosso_cafofo/screens/ForgotPassword.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
          signUpOption(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          externalSignIn(
              context,
              "Entrar com google",
              "assets/images/Login/googleicon.png",
              "FFFFFF",
              "DDDDDD",
              "#2c3333", () async {
            User? user =
                await Authentication.signInWithGoogle(context: context);
            if (user != null) {
              Navigator.pushNamed(context, "/Profile");
            }
          }),
          //Logins extras, adicionar se der tempo
          /*externalSignIn(
              context,
              "Entrar com facebook",
              "assets/images/Login/facebook.png",
              "#3B5998",
              "#324D85",
              "FFFFFF", () {
            signInWithFacebook();
          }),
          externalSignIn(
              context,
              "Entrar com Twitter",
              "assets/images/Login/twittericon.png",
              "#1DA1F2",
              "#1686CA",
              "FFFFFF",
              () {})*/
        ]),
      ),
    );
  }

  Row incorrectPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Dados incorretos, ",
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
/*
Future<UserCredential> signInWithFacebook() async {
  final LoginResult loginResult = await FacebookAuth.instance
      .login(permissions: ['email', 'public_profile']);

  final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);

  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}*/

class Authentication {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
          } else if (e.code == 'invalid-credential') {}
        } catch (e) {}
      }
    }

    return user;
  }
}
