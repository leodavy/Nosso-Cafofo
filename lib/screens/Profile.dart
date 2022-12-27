import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:nosso_cafofo/screens/Cafofo.dart';
import 'package:nosso_cafofo/screens/Notifications.dart';
import '../utils/colors_util.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexStringToColor("#A5c9CA"),
      //Sobrepõe os Widgets
      body: Stack(children: [
        Positioned(
          top: 150,
          left: 50,
          right: 50,
          height: 300,
          child: CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
          ),
        ),
        Positioned(
          bottom: 350,
          right: 50,
          left: 50,
          height: 60,
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
        ),
        Positioned(
          bottom: 230,
          right: 50,
          left: 50,
          height: 200,
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
        ),
        Positioned(
          bottom: 1,
          right: 50,
          left: 50,
          height: 90,
          child: Container(
            child: NavigationBar(
              selectedIndex: _selectedindex,
              onDestinationSelected: (int index) =>
                  setState(() => _selectedindex = index),
              backgroundColor: hexStringToColor("#E7F6F2"),
              destinations: [
                NavigationDestination(
                    icon: Icon(Icons.notifications), label: "Notificiações"),
                NavigationDestination(
                    icon: CircleAvatar(
                      backgroundColor: hexStringToColor("#A5c9CA"),
                      radius: 20,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                    ),
                    label: "Perfil"),
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: "Cafofo",
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
