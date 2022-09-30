// *********************************************************************************
// PARABEAC-GENERATED CODE. DO NOT MODIFY.
//
// FOR MORE INFORMATION ON HOW TO USE PARABEAC, PLEASE VISIT docs.parabeac.com
// *********************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SplashScreen extends StatefulWidget {
  final BoxConstraints constraints;
  final Widget? ovrtelhadocasabranco1;
  final Widget? ovramigos;
  final String? ovrCAFOFO;
  final String? ovrNOSSO;
  final Widget? ovrlinhadireita;
  final Widget? ovrlinhaesquerda;
  final Widget? ovrrede1;
  final String? ovr1622;
  final Widget? ovrwifi1;
  final Widget? ovrbateria1;
  const SplashScreen(
    this.constraints, {
    Key? key,
    this.ovrtelhadocasabranco1,
    this.ovramigos,
    this.ovrCAFOFO,
    this.ovrNOSSO,
    this.ovrlinhadireita,
    this.ovrlinhaesquerda,
    this.ovrrede1,
    this.ovr1622,
    this.ovrwifi1,
    this.ovrbateria1,
  }) : super(key: key);
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xffa5c9ca),
        ),
        child: Stack(children: [
          Positioned(
            left: 25.0,
            width: 326.0,
            top: 0,
            height: 420.047,
            child: Container(
                decoration: BoxDecoration(),
                child: Stack(children: [
                  Positioned(
                    left: 98.0,
                    width: 11.0,
                    top: 299.0,
                    height: 59.018,
                    child: widget.ovrlinhaesquerda ??
                        SvgPicture.asset(
                          'assets/images/linhaesquerda.svg',
                          package: 'nosso',
                          height: 59.01763916015625,
                          width: 11.0,
                          fit: BoxFit.none,
                        ),
                  ),
                  Positioned(
                    left: 0,
                    width: 326.0,
                    top: 0,
                    height: 29.0,
                    child: Container(
                        decoration: BoxDecoration(),
                        child: Stack(children: [
                          Positioned(
                            left: 300.0,
                            width: 26.0,
                            top: 0,
                            height: 26.0,
                            child: widget.ovrbateria1 ??
                                Image.asset(
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
                            child: widget.ovrwifi1 ??
                                Image.asset(
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
                                  widget.ovr1622 ?? '16:22',
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
                            child: widget.ovrrede1 ??
                                Image.asset(
                                  'assets/images/rede1.png',
                                  package: 'nosso',
                                  height: 18.0,
                                  width: 18.0,
                                  fit: BoxFit.none,
                                ),
                          ),
                        ])),
                  ),
                  Positioned(
                    left: 201.771,
                    width: 11.0,
                    top: 298.753,
                    height: 59.018,
                    child: widget.ovrlinhadireita ??
                        SvgPicture.asset(
                          'assets/images/linhadireita.svg',
                          package: 'nosso',
                          height: 59.01763916015625,
                          width: 11.0,
                          fit: BoxFit.none,
                        ),
                  ),
                  Positioned(
                    left: 110.0,
                    width: 91.825,
                    top: 362.0,
                    height: 29.047,
                    child: Container(
                        height: 29.046722412109375,
                        width: 91.82481384277344,
                        child: AutoSizeText(
                          widget.ovrNOSSO ?? 'NOSSO',
                          style: TextStyle(
                            fontFamily: 'Red Hat Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.3799999952316284,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Positioned(
                    left: 102.0,
                    width: 105.474,
                    top: 391.0,
                    height: 29.047,
                    child: Container(
                        height: 29.046722412109375,
                        width: 105.47445678710938,
                        child: AutoSizeText(
                          widget.ovrCAFOFO ?? 'CAFOFO',
                          style: TextStyle(
                            fontFamily: 'Red Hat Text',
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.3799999952316284,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Positioned(
                    left: 91.0,
                    width: 127.0,
                    top: 262.22,
                    height: 128.389,
                    child: widget.ovramigos ??
                        Image.asset(
                          'assets/images/amigos.png',
                          package: 'nosso',
                          height: 128.38937377929688,
                          width: 127.0,
                          fit: BoxFit.none,
                        ),
                  ),
                  Positioned(
                    left: 93.0,
                    width: 125.0,
                    top: 219.0,
                    height: 125.0,
                    child: widget.ovrtelhadocasabranco1 ??
                        Image.asset(
                          'assets/images/telhadocasabranco1.png',
                          package: 'nosso',
                          height: 125.0,
                          width: 125.0,
                          fit: BoxFit.none,
                        ),
                  ),
                ])),
          ),
        ]));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
