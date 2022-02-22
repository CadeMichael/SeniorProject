import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:qr_flutter/qr_flutter.dart';

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
  static const IconData key = IconData(0xf052b, fontFamily: 'MaterialIcons');

  void addKey(str) {
    setState(() {
      sampleKeys.add(str);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: sampleKeys.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                        title: Text(' ${sampleKeys[index]}'),
                        value: true, // need to add functionality
                        onChanged: null, // need to add functionlity
                          secondary: const FaIcon(FontAwesomeIcons.key),
                      );
              }),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            onPressed: () {
              addKey("fuck");
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
