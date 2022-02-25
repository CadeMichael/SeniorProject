import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_crypt/main.dart';
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

class ContactKey {
  ContactKey({
    required this.contactName,
    required this.publicKey,
    this.isExp = false,
  });

  String contactName;
  String publicKey;
  bool isExp;
}

class _KeyListState extends State<KeyList> {
  final List<ContactKey> _keys = [ContactKey(contactName: "cade", publicKey: "123")];

  void addKey(ContactKey newContact) {
    setState(() {
      _keys.add(newContact);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(               // stack allows add button to float over SCSV
      children: [
        SingleChildScrollView(  // SCSV allows for scrolling and gives size to ExpansionPanel
          padding: const EdgeInsets.all(16),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExp) {
              setState(() {
                _keys[index].isExp = !isExp;
              });
            },
            // map the keys to the ExpansionPanel
            children: _keys.map<ExpansionPanel>((ContactKey keyItem) {
              return ExpansionPanel(
                backgroundColor: keyItem.isExp ? darkBlue : darkBG, //if expanded change color
                // contracted state
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    leading: const FaIcon(FontAwesomeIcons.key), //key icon
                    title: Text(keyItem.contactName),
                  );
                },
                // expaded state
                body: ListTile(
                    title: Text(keyItem.publicKey),
                    subtitle: const Text(
                        'detete Contact'),
                    trailing: const Icon(Icons.delete),
                    // delete function **will need to be changed to interact with db**
                    onTap: () {
                      setState(() {
                        _keys.removeWhere(
                            (ContactKey currentItem) => keyItem == currentItem);
                      });
                    }),
                isExpanded: keyItem.isExp,
              );
            }).toList(),
          ),
        ),
        // add button
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            onPressed: () {
              // need to create a dialog that pops up allowing a contact to be added
              addKey(ContactKey(contactName: "test", publicKey: "12Test"));
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
