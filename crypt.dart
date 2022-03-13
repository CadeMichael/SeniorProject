import 'package:flutter/material.dart';
import 'package:the_crypt/main.dart';

/// @Crypt the widget tree that handles both encryption and
/// decryption.
///
/// It will need a text box to input text and a search bar to
/// determine which public key to use.
class Crypt extends StatefulWidget {
  const Crypt({Key? key}) : super(key: key);
  @override
  State<Crypt> createState() => _CryptState();
}

class _CryptState extends State<Crypt> {
  // state determiners
  bool decrypt = false;
  bool encrypt = true;

  // text controllers
  final eCon = TextEditingController();
  final dCon = TextEditingController();

  // resulting text
  String resultText = '';

  void toggle(int i) {}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Text(
            'Encrypt',
            style: TextStyle(color: encrypt ? lightPurp : darkBlue),
          ),
          Switch(
            value: encrypt,
            onChanged: (value) {
              setState(() {
                encrypt = value;
                decrypt = !value;
                dCon.clear();
                eCon.clear();
              });
            },
            activeColor: lightPurp,
            inactiveThumbColor: darkBlue,
            inactiveTrackColor: darkBlue,
          ),
          Text(
            'Decrypt',
            style: TextStyle(color: decrypt ? lightPurp : darkBlue),
          ),
          Switch(
            value: decrypt,
            onChanged: (value) {
              setState(() {
                decrypt = value;
                encrypt = !value;
                dCon.clear();
                eCon.clear();
              });
            },
            activeColor: lightPurp,
            inactiveThumbColor: darkBlue,
            inactiveTrackColor: darkBlue,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 16.0),
            child: TextField(
              // controller depends on toggled
              controller: encrypt ? eCon : dCon,
              decoration: const InputDecoration(
                hintText: "Secret message...",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(64.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: lightPurp,
              ),
              padding: resultText != ''
                  ? const EdgeInsets.all(16.0)
                  : const EdgeInsets.all(0),
                  child: Text(resultText, style: const TextStyle(color: darkBlue),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(
                Icons.sync,
                color: cyan,
                size: 44,
              ),
              splashColor: lightPurp,
              onPressed: () {
                setState(() {
                  resultText = encrypt
                      ? eCon.text + ' but encrypted'
                      : dCon.text + ' but decrypted';
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
