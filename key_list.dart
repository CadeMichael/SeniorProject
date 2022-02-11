import 'package:flutter/material.dart';

// @KeyList is a modified listview to hold saved public keys
// It will need to get data from the Hive DB and update state
// when searching for keys or adding/removing keys 
class KeyList extends StatefulWidget {
  const KeyList({Key? key}) : super(key: key);
  @override
  State<KeyList> createState() => _KeyListState();
}

class _KeyListState extends State<KeyList> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "Key storage",
    );
  }
}
