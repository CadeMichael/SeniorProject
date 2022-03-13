import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_crypt/main.dart';
import 'package:the_crypt/key_pair.dart';
import 'package:the_crypt/person_list_dialog.dart';

/// @Personalkey is a modified listview to hold a user's keys.
///
/// it will hold public and private keys
/// will need some popup for sharing public key
class PersonalKey extends StatefulWidget {
  const PersonalKey({Key? key}) : super(key: key);
  @override
  State<PersonalKey> createState() => _PersonalKeyState();
}

class _PersonalKeyState extends State<PersonalKey> {
  // final List<KeyPair> _keys = [
  //   KeyPair(
  //       keyName: "cade",
  //       publicKey: "123",
  //       privateKey: "priv123",
  //       password: "pass123")
  // ];

  static final store = objectbox.store;
  static final box = store.box<KeyPair>();
  static final que = box.query().build();
  final List<KeyPair> _keys = que.find();

  void newKey(String name) {
    KeyPair newPair = KeyPair(
      keyName: name,
      publicKey: "dummy val",
      privateKey: "dummy val",
      password: "not sure if needed just here in case",
    );
    setState(() {
      _keys.add(newPair);
      box.put(newPair);
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
            children: _keys.map<ExpansionPanel>((KeyPair keyItem) {
              return ExpansionPanel(
                backgroundColor: keyItem.isExp
                    ? darkBlue
                    : darkBG, //if expanded change color
                // contracted state
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    leading: keyItem.isExp
                        ? const FaIcon(FontAwesomeIcons.lockOpen)
                        : const FaIcon(FontAwesomeIcons.lock), //key icon
                    title: Text(keyItem.keyName),
                  );
                },
                // expaded state
                body: ListTile(
                    title: Text(keyItem.privateKey),
                    subtitle: const Text('detete keypair'),
                    trailing: const Icon(Icons.delete),
                    // delete function **will need to be changed to interact with db**
                    onTap: () {
                      setState(() {
                        _keys.removeWhere(
                            (KeyPair currentItem) => keyItem == currentItem);
                          box.remove(keyItem.id);
                      });
                    }),
                isExpanded: keyItem.isExp,
              );
            }).toList(),
          ),
        ),
        // add button
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            onPressed: () {
              // an error is thrown if a new key is Expanded while
              // other keys are expanded
              for (var item in _keys) {
                item.isExp = false;
              }
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddPersonalKeyDialog(
                      keyFunc: newKey, title: "Generate new key");
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
