import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:nosso_cafofo/screens/Cafofo.dart';
import 'package:nosso_cafofo/screens/ModifyProfile.dart';
import '../utils/colors_util.dart';
import 'Notifications.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _currentindex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentindex,
          onTap: (index) {
            setState(() {
              _currentindex = index;
            });
          },
          unselectedFontSize: 13,
          selectedFontSize: 13,
          type: BottomNavigationBarType.fixed,
          backgroundColor: hexStringToColor("#E7F6F2"),
          selectedItemColor: hexStringToColor("#A5c9CA"),
          unselectedItemColor: hexStringToColor("#2C3333"),
          iconSize: 26,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notificações'),
            BottomNavigationBarItem(
                icon: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                ),
                label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Cafofo'),
          ]),
      body: IndexedStack(
        index: _currentindex,
        children: <Widget>[Notifications(), Profilee(), Cafofo()],
      ),
    );
  }
}

class Profilee extends StatelessWidget {
  const Profilee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexStringToColor("#A5c9CA"),
      body: Stack(children: <Widget>[
        Positioned(
          width: MediaQuery.of(context).size.height / 2,
          top: MediaQuery.of(context).size.height / 4,
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 4.2,
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      backgroundColor: hexStringToColor("#E7F6F2"),
                      foregroundColor: hexStringToColor("#2C3333")),
                  onPressed: () {
                    Navigator.pushNamed(context, "/ModifyProfile");
                  },
                  child: Text("Alterar Perfil"),
                ),
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  height: MediaQuery.of(context).size.height / 30,
                  width: MediaQuery.of(context).size.width / 3,
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
                  ))
            ],
          ),
        ),
      ]),
    );
  }
}
