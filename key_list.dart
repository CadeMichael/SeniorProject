import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_crypt/main.dart';
import 'package:the_crypt/contact_key.dart';
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

class _KeyListState extends State<KeyList> {
  // in order to use objectbox components as initializers they must be static
  // get the "store" from objectbox
  static final store = objectbox.store;
  // get a "box" of ContactKeys
  static final box = store.box<ContactKey>();
  // query the keys, no params means all keys
  static final que = box.query().build();
  // find() turns that query into a list of box<Type> in this case ContactKeys
  final List<ContactKey> _keys = que.find();

  /// function for adding a new contact key
  void addKey(String name, String key) {
    ContactKey newContact = ContactKey(contactName: name, publicKey: key);
    setState(() {
      _keys.add(newContact);
      box.put(newContact);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // stack allows add button to float over SCSV
      children: [
        SingleChildScrollView(
          // SCSV allows for scrolling and gives size to ExpansionPanel
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
                        null;
                      },
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.bottomRight,
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _keys.removeWhere((ContactKey currentItem) =>
                              keyItem == currentItem);
                          box.remove(keyItem.id);
                        });
                      },
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
          child: FloatingActionButton(
            splashColor: lightPurp,
            onPressed: () {
              // an error is thrown if a new key is Expanded while
              // other keys are expanded
              for (var item in _keys) {
                item.isExp = false;
              }
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddKeyDialog(keyFunc: addKey, title: "Add Contact");
                },
              );
            },
            child: const Icon(Icons.vpn_key),
          ),
        ),
      ],
    );
  }
}
