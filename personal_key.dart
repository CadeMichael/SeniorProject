import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_crypt/main.dart';

/// @Personalkey is a modified listview to hold a user's keys.
///
/// it will hold public and private keys
/// will need some popup for sharing public key
class PersonalKey extends StatefulWidget {
  const PersonalKey({Key? key}) : super(key: key);
  @override
  State<PersonalKey> createState() => _PersonalKeyState();
}

/// KeyPair holds the users personal key pairs
/// [keyName] is name of the individual pair ie, personal or work
/// [publicKey] is the public key
/// [privateKey] is the public key
/// [password] is the password for the private key
class KeyPair {
  // constructor
  KeyPair({
    required this.keyName,
    required this.publicKey,
    required this.privateKey,
    required this.password,
    this.isExp = false,
  });

  // fields
  String keyName;
  String publicKey;
  String privateKey;
  String password;
  bool isExp;
}

class _PersonalKeyState extends State<PersonalKey> {
  final List<KeyPair> _keys = [
    KeyPair(
        keyName: "cade",
        publicKey: "123",
        privateKey: "priv123",
        password: "pass123")
  ];

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
              // need to create a dialog that pops up allowing a contact to be added
              null;
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
