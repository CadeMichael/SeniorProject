import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_crypt/main.dart';
import 'package:the_crypt/key_pair.dart';
import 'package:the_crypt/person_list_dialog.dart';
import 'package:fast_rsa/fast_rsa.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
  // in order to use objectbox components as initializers they must be static
  // get the "store" from objectbox
  static final store = objectbox.store;
  // get a "box" of PersonalPairs
  static final box = store.box<PersonalPair>();
  // query the keys, no params means all keys
  static final que = box.query().build();
  // find() turns that query into a list of box<Type> in this case PersonalPairs
  final List<PersonalPair> _keys = que.find();

  /// function to generate and add a new keypair
  void newKey(String name) async {
    var keys = await RSA.generate(2048);
    PersonalPair newPair = PersonalPair(
      keyName: name,
      publicKey: keys.publicKey,
      privateKey: keys.privateKey,
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
            children: _keys.map<ExpansionPanel>((PersonalPair keyItem) {
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
                body: Column(
                  children: [
                    ListTile(
                      title: const Text("RSA Private Key"),
                      subtitle: const Text('Copy Priv Key'),
                      trailing: const Icon(Icons.copy),
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: keyItem.privateKey,
                          ),
                        );
                        null;
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: QrImage(
                        size: 275,
                        data: keyItem.publicKey,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Copy Public Key"),
                        IconButton(
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.bottomRight,
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: keyItem.publicKey,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.bottomRight,
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _keys.removeWhere((PersonalPair currentItem) =>
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
            child: const Icon(Icons.lock),
          ),
        ),
      ],
    );
  }
}
