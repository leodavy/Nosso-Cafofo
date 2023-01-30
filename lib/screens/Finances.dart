import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/colors_util.dart';

class Finances extends StatefulWidget {
  const Finances({Key? key}) : super(key: key);

  @override
  _FinancesState createState() => _FinancesState();
}

class _FinancesState extends State<Finances> {
  var user = FirebaseAuth.instance.currentUser;
  String cafofoPkey = '';
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  var items = [];
  double totalCost = 0;

  get() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .get()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('cafofos')
          .doc(value['cafofo'])
          .get()
          .then((data) {
        this.cafofoPkey = (value['cafofo']);
        this.items = (data['finances']);
      });
    });
  }

  retrieve() async {
    await get();
    for (int i = 0; i < this.items.length; i++) {
      this.totalCost += double.parse(
          this.items[i].substring(this.items[i].lastIndexOf("\$") + 1));
      _key.currentState!.insertItem(0, duration: const Duration(seconds: 1));
    }
    setState(() {});
  }

  void _addItem(String title) {
    items.insert(0, title);
    _key.currentState!.insertItem(0, duration: const Duration(seconds: 1));
    FirebaseFirestore.instance
        .collection('cafofos')
        .doc(cafofoPkey)
        .update({'finances': items});
    _addNotification(title);
  }

  void _addNotification(String title) async {
    String userName = '';
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .get()
        .then((value) {
      userName = value['name'];
    });
    await FirebaseFirestore.instance
        .collection('cafofos')
        .doc(cafofoPkey)
        .update({
      'notifications': FieldValue.arrayUnion(
          ['Nova dívida: ${title}, adicionada por: ${userName}'])
    });
  }

  Future<void> addDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: hexStringToColor("#E7F6F2"),
            title: const Text(
              'Adicione um item a lista:',
            ),
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              TextField(
                cursorColor: hexStringToColor("#2C3333"),
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: '',
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text("Valor: "),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                cursorColor: hexStringToColor("#2C3333"),
                controller: _valueController,
                decoration: const InputDecoration(
                  hintText: '',
                ),
              )
            ]),
            actions: [
              TextButton(
                onPressed: () {
                  this.totalCost += double.parse(_valueController.text);
                  _addItem(_controller.text + " - R\$" + _valueController.text);
                  Navigator.pop(context);
                  _controller.clear();
                  _valueController.clear();
                },
                child: const Text('Adicionar',
                    style: TextStyle(color: Colors.black)),
              )
            ],
          );
        }));
  }

  void _removeItem(int index) {
    _key.currentState!.removeItem(index, (_, animation) {
      return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: SizeTransition(
            sizeFactor: animation,
          ));
    }, duration: const Duration(seconds: 1));
    this.totalCost -= double.parse(
        this.items[index].substring(this.items[index].lastIndexOf("\$") + 1));
    items.removeAt(index);
    FirebaseFirestore.instance
        .collection('cafofos')
        .doc(cafofoPkey)
        .update({'finances': items});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (this.cafofoPkey == '') {
      retrieve();
    }
    return Scaffold(
      backgroundColor: hexStringToColor("#A5c9CA"),
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            child: AppBar(
                iconTheme: IconThemeData(color: hexStringToColor("#2C3333")),
                title: Text("Finanças",
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
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Center(
              child: Container(
            height: MediaQuery.of(context).size.height * 0.03,
            width: MediaQuery.of(context).size.width * 0.90,
            decoration: BoxDecoration(
                color: hexStringToColor("#E7F6F2"),
                borderRadius: BorderRadius.circular(25)),
            child: Text("Valor total das dívidas: R\$${totalCost.toString()}",
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center),
          )),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          AnimatedList(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            key: _key,
            itemBuilder: (context, index, animation) {
              return Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.01,
                    0,
                    MediaQuery.of(context).size.width * 0.01,
                    MediaQuery.of(context).size.height * 0.01),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: hexStringToColor("#E7F6F2")),
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.04,
                      MediaQuery.of(context).size.height * 0.01 / 2,
                      MediaQuery.of(context).size.width * 0.03,
                      MediaQuery.of(context).size.height * 0.01 / 2),
                  title: Text(
                    items[index],
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.redAccent,
                    onPressed: () {
                      _removeItem(index);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: hexStringToColor("#395B64"),
        onPressed: () {
          _controller.clear();
          addDialog(context);
        },
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
