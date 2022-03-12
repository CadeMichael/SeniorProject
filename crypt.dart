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
  bool decrypt = false;
  bool encrypt = false;

  void toggle(int i) {}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Text('Encrypt', style: TextStyle(color: encrypt ? lightPurp : darkBlue),),
          Switch(
              value: encrypt,
              onChanged: (value) {
                setState(() {
                  encrypt = value;
                  decrypt = !value;
                });
              },
              activeColor: lightPurp,
              inactiveThumbColor: darkBlue,
              inactiveTrackColor: darkBlue,
            ),
          Text('Decrypt', style: TextStyle(color: decrypt ? lightPurp : darkBlue),),
          Switch(
              value: decrypt,
              onChanged: (value) {
                setState(() {
                  decrypt = value;
                  encrypt = !value;
                });
              },
              activeColor: lightPurp,
              inactiveThumbColor: darkBlue,
              inactiveTrackColor: darkBlue,
            ),
          const Text('input feild coming'),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.sync,
                color: cyan,
                size: 44,
              ),
              splashColor: lightPurp,
              onPressed: null,
            ),
          ),
        ],
      ),
    );
  }
}
