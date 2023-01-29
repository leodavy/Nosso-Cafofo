import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nosso_cafofo/utils/widgets_util.dart';
import '../utils/colors_util.dart';

class Residents extends StatefulWidget {
  Residents({Key? key}) : super(key: key);

  _ResidentState createState() => _ResidentState();
}

class _ResidentState extends State<Residents> {
  var user = FirebaseAuth.instance.currentUser;
  var userDoc = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.email.toString());
  var cafofoPkey;
  List<String> residents = [''];
  bool first = true;
  get() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email.toString())
        .get()
        .then((value) async {
      this.cafofoPkey = value['cafofo'];
      await FirebaseFirestore.instance
          .collection('cafofos')
          .doc(value['cafofo'])
          .get()
          .then((data) {
        this.residents = List.from(data['members']);
      });
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (this.residents[0] == '') {
      get();
      getWidgets(context, this.residents);
      setState(() {});
    }

    setState(() {});
    return Scaffold(
        backgroundColor: hexStringToColor("#A5c9CA"),
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              child: AppBar(
                  iconTheme: IconThemeData(color: hexStringToColor("#2C3333")),
                  title: Text("Moradores",
                      style: TextStyle(color: hexStringToColor("#2C3333"))),
                  centerTitle: true,
                  backgroundColor: hexStringToColor("#E7F6F2"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0)))),
            ),
          ),
        ),
        body: Center(
            child: FutureBuilder(
                future: getWidgets(context, this.residents),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return new ListView();
                    case ConnectionState.waiting:
                      return new ListView(children: [SizedBox(height: MediaQuery.of(context).size.height*0.01),
                        Center(
                            child: Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: MediaQuery.of(context).size.height * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  MediaQuery.of(context).size.height *
                                      (0.08 / 3))),
                              color: hexStringToColor("#E7F6F2")),
                          child: Center(
                              child: Text("Carregando...",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      color: hexStringToColor("#252B2B"),
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center)),
                        ))
                      ]);
                    case ConnectionState.active:
                      return new ListView(children: [
                        Center(
                            child: Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: MediaQuery.of(context).size.height * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  MediaQuery.of(context).size.height *
                                      (0.08 / 3))),
                              color: hexStringToColor("#E7F6F2")),
                          child: Center(
                              child: Text("Carregando...",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      color: hexStringToColor("#252B2B"),
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center)),
                        ))
                      ]);
                    case ConnectionState.done:
                      return snapshot.hasData ? snapshot.data! : new ListView();
                    default:
                      return new ListView();
                  }
                })));
  }
}

Future<ListView> getWidgets(var context, var members) async {
  final children = <Widget>[];
  for (int i = 0; i < members.length; i++) {
    children.add(SizedBox(
      height: MediaQuery.of(context).size.height * 0.01,
    ));
    children.add(await generateWidget(context, members[i]));
  }
  return new ListView(
    padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * (0.15 / 2),
        MediaQuery.of(context).size.width * 0.03,
        MediaQuery.of(context).size.width * (0.15 / 2),
        MediaQuery.of(context).size.width * 0.03),
    children: children,
  );
}

Future<Container> generateWidget(var context, String userPkey) async {
  Image profilePic = await getProfilePic(context, userPkey);
  String username = await getUserName(userPkey);
  return new Container(
    width: MediaQuery.of(context).size.width * 0.75,
    height: MediaQuery.of(context).size.height * 0.08,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(MediaQuery.of(context).size.height)),
        color: hexStringToColor("#E7F6F2")),
    child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      SizedBox(
        width: 10,
      ),
      CircleAvatar(
        radius: 50,
        backgroundImage: profilePic.image,
      ),
      Text(
        username,
        style: TextStyle(fontSize: 20, color: hexStringToColor("#2C3333")),
      ),
      SizedBox(
        width: 10,
      )
    ]),
  );
}

Future<Image> getProfilePic(var context, String userPkey) async {
  String url = "";
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userPkey)
        .get()
        .then((value) {
      url = value['profilePic'];
    });
  }catch(error){}
  return url != ""
      ? imgLinkWidget(url, MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.width)
      : imgWidget("assets/images/WithoutProfilePic.png",
          MediaQuery.of(context).size.width, MediaQuery.of(context).size.width);
}

Future<String> getUserName(String userPkey) async {
  String userName = "";
  try{
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userPkey)
        .get()
        .then((value) {
      userName = value['name'];
    });
  }catch(error){}
  return userName;
}
