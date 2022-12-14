import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../utils/colors_util.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: hexStringToColor("#A5c9CA"),
        body: Stack(//Sobrepõe os Widgets
            children: [
          ProfileImage(),
          ModifyProfile(context),
          Logout(context),
          BottonBar()
        ]));
  }

  Widget ProfileImage() => Container(
      height: 600,
      alignment: Alignment.center,
      child: CircleAvatar(
        radius: 100,
        backgroundImage: NetworkImage(
            "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
      ));

  Widget ModifyProfile(context) => Container(
        height: 900,
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: hexStringToColor("#E7F6F2"),
              padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
              shape: StadiumBorder()),
          child: Text("Alterar Perfil",
              style: TextStyle(
                fontSize: 15,
                color: hexStringToColor("#2C3333"),
              )),
          onPressed: () {
            Navigator.pushNamed(context, "/ModifyProfile");
          },
        ),
      );

  Widget Logout(context) => Container(
        height: 500,
        alignment: Alignment.bottomCenter,
        child: TextButton(
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              print("Signed out");
              Navigator.restorablePushNamed(context, "/login");
            });
          },
          style: TextButton.styleFrom(
            alignment: Alignment.center,
          ),
          child: Text("Desconectar",
              style: TextStyle(
                  color: hexStringToColor("#2C3333"),
                  decoration: TextDecoration.underline,
                  fontSize: 15)),
        ),
      );

  Widget BottonBar() => Container(
        height: 900,
        alignment: Alignment.bottomCenter,
        child: BottomNavigationBar(
          currentIndex: 1,
          selectedIconTheme: IconThemeData(
            shadows: <Shadow>[
              Shadow(color: hexStringToColor("#A5C9CA"), blurRadius: 1)
            ],
          ),
          iconSize: 30,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.add_alert),
                label: "Notificações",
                backgroundColor: hexStringToColor("#E7F6F2")),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
              ),
              label: "Perfil",
              backgroundColor: hexStringToColor("#E7F6F2"),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Cafofo",
                backgroundColor: hexStringToColor("#E7F6F2")),
          ],
        ),
      );
}
