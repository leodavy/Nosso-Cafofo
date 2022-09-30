// *********************************************************************************
// PARABEAC-GENERATED CODE. DO NOT MODIFY.
//
// FOR MORE INFORMATION ON HOW TO USE PARABEAC, PLEASE VISIT docs.parabeac.com
// *********************************************************************************

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class EsqueceuASenha extends StatefulWidget {
  final BoxConstraints constraints;
  final String? ovresqueceuasenha;
  const EsqueceuASenha(
    this.constraints, {
    Key? key,
    this.ovresqueceuasenha,
  }) : super(key: key);
  @override
  _EsqueceuASenha createState() => _EsqueceuASenha();
}

class _EsqueceuASenha extends State<EsqueceuASenha> {
  _EsqueceuASenha();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(),
        child: Stack(children: [
          Positioned(
            left: 0,
            width: widget.constraints.maxWidth * 1.0,
            top: 0,
            height: widget.constraints.maxHeight * 1.0,
            child: Container(
                height: widget.constraints.maxHeight * 1.0,
                width: widget.constraints.maxWidth * 1.0,
                child: AutoSizeText(
                  widget.ovresqueceuasenha ?? 'esqueceu a senha?',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.3799999952316284,
                    color: Color(0xff2c3333),
                  ),
                  textAlign: TextAlign.center,
                )),
          ),
        ]));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
