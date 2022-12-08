import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(84, 110, 122, 1), // fundo da tela
        child: SizedBox(
          height: 128,
          width: 128,
          child: CircleAvatar(
            backgroundImage:
                AssetImage("assets/images/Profile/ProfileIcon.png"),
          ),
        ),
      ),
    );
  }
}
