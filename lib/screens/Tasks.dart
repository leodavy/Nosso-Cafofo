import 'package:flutter/material.dart';

import '../utils/colors_util.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final _items = [];
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final bool textcenter = true;
    final GlobalKey<AnimatedListState> _key = GlobalKey();
    final TextEditingController _controller = TextEditingController();

    void _addItem(String title) {
      _items.insert(0, title);
      _key.currentState!.insertItem(0, duration: const Duration(seconds: 1));
    }

    Future<void> addDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              backgroundColor: hexStringToColor("#E7F6F2"),
              title: const Text(
                'Adicione um item à lista:',
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
                centerTitle: textcenter,
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
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: hexStringToColor("#E7F6F2")),
            child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              title: Text(
                _items[index],
                style: TextStyle(fontSize: 24, color: Colors.black),
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
