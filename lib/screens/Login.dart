import 'package:flutter/material.dart';

class Login extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
    Widget build(BuildContext context){
      return new MaterialApp(
        home: new Scaffold(
          body: new Container(
            color:Colors.blueGrey[600],
            child: new Container(
              height: 175.05 ,
              width: 127,
              child: 
                Image.asset('assets/images/Login/Icone.png')
              ),

            )
        )
        )
        ;
    }

  }


