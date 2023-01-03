import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import '../utils/colors_util.dart';

class ModifyProfile extends StatelessWidget {
  const ModifyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: hexStringToColor("#A5c9CA"),
        child: Center(child: Text("Modificar Perfil")));
  }
}
