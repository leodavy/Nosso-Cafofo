// *********************************************************************************
// PARABEAC-GENERATED CODE. DO NOT MODIFY.
//
// FOR MORE INFORMATION ON HOW TO USE PARABEAC, PLEASE VISIT docs.parabeac.com
// *********************************************************************************

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Perfil extends StatefulWidget {
  const Perfil({
    Key? key,
  }) : super(key: key);
  @override
  _Perfil createState() => _Perfil();
}

class _Perfil extends State<Perfil> {
  _Perfil();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffa5c9ca),
      child: Stack(children: [
        Positioned(
          left: 17.0,
          width: 360.0,
          top: 29.0,
          height: 640.0,
          child: Image.asset(
            'assets/images/bordainvertida.png',
            package: 'nosso',
            height: 640.0,
            width: 360.0,
            fit: BoxFit.none,
          ),
        ),
        Positioned(
          left: 0,
          width: 524.0,
          top: 0,
          height: 884.0,
          child: Image.asset(
            'assets/images/borda1.png',
            package: 'nosso',
            height: 884.0,
            width: 524.0,
            fit: BoxFit.none,
          ),
        ),
        Positioned(
          left: 13.0,
          width: 365.0,
          top: 587.0,
          height: 105.0,
          child: Container(
            height: 105.0,
            width: 365.0,
            decoration: BoxDecoration(
              color: Color(0xffe7f6f2),
              borderRadius: BorderRadius.all(Radius.circular(18)),
            ),
          ),
        ),
        Positioned(
          left: 298.0,
          width: 32.0,
          top: 611.0,
          height: 32.0,
          child: Container(
              decoration: BoxDecoration(),
              child: Stack(children: [
                Positioned(
                  left: 0,
                  width: 32.0,
                  top: 0,
                  height: 32.0,
                  child: Image.asset(
                    'assets/images/cafofo.png',
                    package: 'nosso',
                    height: 32.0,
                    width: 32.0,
                    fit: BoxFit.none,
                  ),
                ),
              ])),
        ),
        Positioned(
          left: 164.0,
          width: 64.0,
          top: 597.0,
          height: 72.0,
          child: Container(
              decoration: BoxDecoration(),
              child: Stack(children: [
                Positioned(
                  left: 0,
                  width: 64.0,
                  top: 0,
                  height: 72.0,
                  child: Container(
                    height: 72.0,
                    width: 64.0,
                    decoration: BoxDecoration(
                      color: Color(0xffa5c9ca),
                    ),
                  ),
                ),
                Positioned(
                  left: 11.0,
                  width: 39.0,
                  top: 10.0,
                  height: 39.0,
                  child: Image.asset(
                    'assets/images/fotoperfil.png',
                    package: 'nosso',
                    height: 39.0,
                    width: 39.0,
                    fit: BoxFit.none,
                  ),
                ),
              ])),
        ),
        Positioned(
          left: 50.0,
          width: 29.0,
          top: 612.0,
          height: 33.0,
          child: Container(
              decoration: BoxDecoration(),
              child: Stack(children: [
                Positioned(
                  left: 0,
                  width: 29.0,
                  top: 0,
                  height: 33.0,
                  child: Image.asset(
                    'assets/images/notificacao1.png',
                    package: 'nosso',
                    height: 33.0,
                    width: 29.0,
                    fit: BoxFit.none,
                  ),
                ),
              ])),
        ),
        Positioned(
          left: 118.0,
          width: 156.0,
          top: 456.0,
          height: 44.0,
          child: Container(
            height: 44.0,
            width: 156.0,
            decoration: BoxDecoration(
              color: Color(0xffe7f6f2),
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
          ),
        ),
        Positioned(
          left: 118.0,
          width: 156.0,
          top: 385.0,
          height: 44.0,
          child: Container(
            height: 44.0,
            width: 156.0,
            decoration: BoxDecoration(
              color: Color(0xffe7f6f2),
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
          ),
        ),
        Positioned(
          left: 118.0,
          width: 156.0,
          top: 313.0,
          height: 44.0,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(22)),
              ),
              child: Stack(children: [
                Positioned(
                  left: 0,
                  width: 156.0,
                  top: 0,
                  height: 44.0,
                  child: Container(
                    height: 44.0,
                    width: 156.0,
                    decoration: BoxDecoration(
                      color: Color(0xffe7f6f2),
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                    ),
                  ),
                ),
                Positioned(
                  left: 32.0,
                  width: 92.0,
                  top: 12.0,
                  height: 24.0,
                  child: Container(
                      height: 24.0,
                      width: 92.0,
                      child: AutoSizeText(
                        'Alterar Perfil',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.3799999952316284,
                          color: Color(0xff2c3333),
                        ),
                        textAlign: TextAlign.center,
                      )),
                ),
              ])),
        ),
        Positioned(
          left: 160.0,
          width: 71.0,
          top: 510.0,
          height: 24.0,
          child: Container(
              height: 24.0,
              width: 71.0,
              child: AutoSizeText(
                'Desconectar',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3799999952316284,
                  color: Color(0xff395b64),
                ),
                textAlign: TextAlign.center,
              )),
        ),
        Positioned(
          left: 112.0,
          width: 166.0,
          top: 109.0,
          height: 166.0,
          child: Image.asset(
            'assets/images/fotoperfil.png',
            package: 'nosso',
            height: 166.0,
            width: 166.0,
            fit: BoxFit.none,
          ),
        ),
        Positioned(
          left: 41.0,
          width: 326.0,
          top: 29.0,
          height: 29.0,
          child: Container(
              decoration: BoxDecoration(),
              child: Stack(children: [
                Positioned(
                  left: 300.0,
                  width: 26.0,
                  top: 0,
                  height: 26.0,
                  child: Image.asset(
                    'assets/images/bateria1.png',
                    package: 'nosso',
                    height: 26.0,
                    width: 26.0,
                    fit: BoxFit.none,
                  ),
                ),
                Positioned(
                  left: 274.0,
                  width: 18.0,
                  top: 4.0,
                  height: 18.0,
                  child: Image.asset(
                    'assets/images/wifi1.png',
                    package: 'nosso',
                    height: 18.0,
                    width: 18.0,
                    fit: BoxFit.none,
                  ),
                ),
                Positioned(
                  left: 0,
                  width: 41.0,
                  top: 5.0,
                  height: 24.0,
                  child: Container(
                      height: 24.0,
                      width: 41.0,
                      child: AutoSizeText(
                        '16:22',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.3799999952316284,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      )),
                ),
                Positioned(
                  left: 245.0,
                  width: 18.0,
                  top: 5.0,
                  height: 18.0,
                  child: Image.asset(
                    'assets/images/rede1.png',
                    package: 'nosso',
                    height: 18.0,
                    width: 18.0,
                    fit: BoxFit.none,
                  ),
                ),
              ])),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
