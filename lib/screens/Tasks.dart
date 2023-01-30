import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/colors_util.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  var user = FirebaseAuth.instance.currentUser;
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  final TextEditingController _controller = TextEditingController();
  var _items = [];
  String cafofoPkey = '';
  bool once = true;

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
        this._items = (data['tasks']);
      });
    });
  }

  retrieve() async {
    await get();
    for (int i = 0; i < this._items.length; i++) {
      _key.currentState!.insertItem(0, duration: const Duration(seconds: 1));
    }
  }

  void _addItem(String title) {
    _items.insert(0, title);
    _key.currentState!.insertItem(0, duration: const Duration(seconds: 1));
    FirebaseFirestore.instance
        .collection('cafofos')
        .doc(cafofoPkey)
        .update({'tasks': _items});
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
          ['Nova tarefa: ${title}, adicionada por: ${userName}'])
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
            content: TextField(
              cursorColor: hexStringToColor("#2C3333"),
              controller: _controller,
              decoration: const InputDecoration(
                hintText: '',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _addItem(_controller.text);
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
    _key.currentState!.removeItem(index, (_, animation) {
      return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: SizeTransition(
            sizeFactor: animation,
          ));
    }, duration: const Duration(seconds: 1));

    _items.removeAt(index);
    FirebaseFirestore.instance
        .collection('cafofos')
        .doc(cafofoPkey)
        .update({'tasks': _items});
  }

  @override
  Widget build(BuildContext context) {
    if (once) {
      retrieve();
      once = false;
    }
    return Scaffold(
      backgroundColor: hexStringToColor("#A5c9CA"),
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            child: AppBar(
                iconTheme: IconThemeData(color: hexStringToColor("#2C3333")),
                title: Text("Tarefas",
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
      body: AnimatedList(
        key: _key,
        itemBuilder: (context, index, animation) {
          return Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: hexStringToColor("#E7F6F2")),
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.width * 0.01,
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.width * 0.01),
              title: Text(
                _items[index],
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
