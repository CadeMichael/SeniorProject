import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_crypt/main.dart';
import 'package:the_crypt/key_list_dialog.dart';

/// @KeyList is a modified listview to hold saved public keys.
///
/// It will need to get data from the Hive DB and update state
/// when searching for keys or adding/removing keys
class KeyList extends StatefulWidget {
  const KeyList({Key? key}) : super(key: key);

  @override
  State<KeyList> createState() => _KeyListState();
}

/// ContactKey holds the public Keys of your contacts
/// [contactName] is the contacts name
/// [publicKey] is their public key
class ContactKey {
  // constructor
  ContactKey({
    required this.contactName,
    required this.publicKey,
    this.isExp = false,
  });

  // fields
  String contactName;
  String publicKey;
  bool isExp;
}

class _KeyListState extends State<KeyList> {
  final List<ContactKey> _keys = [
    ContactKey(contactName: "cade", publicKey: "123")
  ];

  void addKey(String name, String key) {
    ContactKey newContact = ContactKey(contactName: name, publicKey: key);
    setState(() {
      _keys.add(newContact);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // stack allows add button to float over SCSV
      children: [
        SingleChildScrollView(
          // SCSV allows for scrolling and gives size to ExpansionPanel
          padding: const EdgeInsets.all(24),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExp) {
              setState(() {
                _keys[index].isExp = !isExp;
              });
            },
            // map the keys to the ExpansionPanel
            children: _keys.map<ExpansionPanel>((ContactKey keyItem) {
              return ExpansionPanel(
                backgroundColor: keyItem.isExp
                    ? darkBlue
                    : darkBG, //if expanded change color
                // contracted state
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    leading: const FaIcon(FontAwesomeIcons.key), //key icon
                    title: Text(keyItem.contactName),
                  );
                },
                // expaded state
                body: Column(
                  children: [
                    ListTile(
                      title: Text(keyItem.publicKey),
                      subtitle: const Text('Copy Key'),
                      trailing: const Icon(Icons.copy),
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: keyItem.publicKey,
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.centerRight,
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _keys.removeWhere((ContactKey currentItem) =>
                                  keyItem == currentItem);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                isExpanded: keyItem.isExp,
              );
            }).toList(),
          ),
        ),
        // add button
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: FloatingActionButton(
              splashColor: lightPurp,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddKeyDialog(keyFunc: addKey, title: "Add Contact");
                  },
                );
                // addKey(ContactKey(contactName: "test", publicKey: "12Test"));
              },
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}
