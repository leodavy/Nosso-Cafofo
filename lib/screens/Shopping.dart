import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/colors_util.dart';

class Shopping extends StatefulWidget {
  const Shopping({Key? key}) : super(key: key);

  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  var user = FirebaseAuth.instance.currentUser;
  List<List<String>> _items = [];
  String cafofoPkey = '';
  bool once = true;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _qtdcontroller = TextEditingController();

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
        this.cafofoPkey = value['cafofo'];
        this._items = matrixFromMap(data['shopping']);
      });
    });
    setState(() {});
  }

  void _addItem(String str, qtd) {
    List<String> temp = [str, qtd];
    _items.insert(0, temp);
    FirebaseFirestore.instance
        .collection('cafofos')
        .doc(cafofoPkey)
        .update({'shopping': mapFromMatrix(_items)});
    setState(() {});
    _addNotification(str);
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
      'notifications': FieldValue.arrayUnion([
        'Novo item no carrinho de compras: ${title}, adicionado por: ${userName}'
      ])
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
              Text(" Quantidade: "),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                cursorColor: hexStringToColor("#2C3333"),
                controller: _qtdcontroller,
                decoration: const InputDecoration(
                  hintText: '',
                ),
              )
            ]),
            actions: [
              TextButton(
                onPressed: () {
                  _addItem(_controller.text, _qtdcontroller.text);
                  Navigator.pop(context);
                },
                child: const Text('Adicionar',
                    style: TextStyle(color: Colors.black)),
              )
            ],
          );
        }));
  }

  void _removeItem(int index) {
    _items.removeAt(index);
    FirebaseFirestore.instance
        .collection('cafofos')
        .doc(cafofoPkey)
        .update({'shopping': _items});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    get();
    return Scaffold(
      backgroundColor: hexStringToColor("#A5c9CA"),
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            child: AppBar(
                iconTheme: IconThemeData(color: hexStringToColor("#2C3333")),
                title: Text("Compras",
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
      body: Center(child: buildList(_items, context)),
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

ListView buildList(var items, var context) {
  final children = <Widget>[];
  children.add(SizedBox(
    height: MediaQuery.of(context).size.height * 0.01,
  ));
  children.add(buildRow(['Qtd', 'Nome'], context));
  for (int i = 0; i < items.length; i++) {
    children.add(SizedBox(
      height: MediaQuery.of(context).size.height * 0.01,
    ));
    children.add(buildRow(items[i], context));
  }
  return new ListView(
    padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * (0.05),
        MediaQuery.of(context).size.width * 0.01,
        MediaQuery.of(context).size.width * (0.05),
        MediaQuery.of(context).size.width * 0.01),
    children: children,
  );
}

Row buildRow(var item, var context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: hexStringToColor('#E7F6F2')),
          child: Center(
              child: Text(item[1],
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      color: hexStringToColor("#252B2B")),
                  textAlign: TextAlign.center))),
      Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: hexStringToColor('#E7F6F2')),
          child: Center(
              child: Text(item[0],
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      color: hexStringToColor("#252B2B")),
                  textAlign: TextAlign.center)))
    ],
  );
}

Map<String, dynamic> mapFromMatrix(List<List<String>> matrix) {
  Map<String, Map<String, dynamic>> map = {};
  int index = 0;
  for (List<String> row in matrix) {
    map.addEntries([MapEntry(index.toString(), {})]);
    for (String value in row) {
      map[index.toString()]?.addEntries([MapEntry(value, true)]);
    }
    index += 1;
  }
  return map;
}

List<List<String>> matrixFromMap(Map<dynamic, dynamic> dynamicMap) {
  final map = Map<String, dynamic>.from(dynamicMap);
  List<List<String>> matrix = [];
  map.forEach((stringIndex, value) {
    Map<String, dynamic> rowMap = Map<String, dynamic>.from(value);
    List<String> row = [];
    rowMap.forEach((string, boolean) {
      row.add(string);
    });
    matrix.add(row);
  });
  return matrix;
}
