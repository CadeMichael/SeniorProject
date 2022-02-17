import 'package:flutter/material.dart';

/// @KeyList is a modified listview to hold saved public keys.
///
/// It will need to get data from the Hive DB and update state
/// when searching for keys or adding/removing keys
class KeyList extends StatefulWidget {
  const KeyList({Key? key}) : super(key: key);
  @override
  State<KeyList> createState() => _KeyListState();
}

class _KeyListState extends State<KeyList> {
  List<String> sampleKeys = ["cade's key", "tom's key"];
  void addkey() {
    setState(() {
      sampleKeys.add("value");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.topRight,
          child: FloatingActionButton(
            onPressed: addkey,
            child: const Icon(Icons.add),
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: sampleKeys.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Row(
                    children: [
                      Text(' ${sampleKeys[index]}'),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
