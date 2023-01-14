import 'package:flutter/material.dart';

import '../utils/colors_util.dart';

class Shopping extends StatefulWidget {
  const Shopping({Key? key}) : super(key: key);

  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  final _items = [];
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final bool textcenter = true;
    final GlobalKey<AnimatedListState> _key = GlobalKey();

    void _addItem() {
      _items.insert(0, "Item ${_items.length + 1}");
      _key.currentState!.insertItem(0, duration: const Duration(seconds: 1));
    }

    void _removeItem(int index) {
      _key.currentState!.removeItem(index, (_, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: const Card(
            margin: EdgeInsets.all(10),
            elevation: 10,
            color: Colors.purple,
            child: ListTile(
              contentPadding: EdgeInsets.all(15),
              title: Text("removing", style: TextStyle(fontSize: 24)),
            ),
          ),
        );
        ;
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
                title: Text("Compras",
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
          return SizeTransition(
              key: UniqueKey(),
              sizeFactor: animation,
              child: Card(
                margin: const EdgeInsets.all(10),
                elevation: 10,
                color: Colors.blue,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  title: Text(
                    _items[index],
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.redAccent,
                    onPressed: () {
                      _removeItem(index);
                    },
                  ),
                ),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: hexStringToColor("#395B64"),
        onPressed: _addItem,
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
