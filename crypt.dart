import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_crypt/main.dart';
import 'package:fast_rsa/fast_rsa.dart';

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
  String? keyString = '';

  void toggle(int i) {}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
              padding: const EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 36.0),
              child: TextField(
                // controller depends on toggled
                controller: encrypt ? eCon : dCon,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Secret message...",
                  focusColor: lightPurp,
                  hoverColor: lightPurp,
                ),
                minLines: 5,
                maxLines: 7,
              ),
            ),
            FloatingActionButton(
              child: const Icon(
                Icons.vpn_key,
              ),
              backgroundColor: cyan,
              splashColor: green,
              onPressed: () {
                Clipboard.getData(Clipboard.kTextPlain).then((value) {
                  keyString = value?.text;
                });
              },
            ),
            Padding(
              padding: resultText != ''
                  ? const EdgeInsets.all(64.0)
                  : const EdgeInsets.all(8),
              child: resultText != ''
                  ? Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: lightPurp,
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            resultText,
                            style: const TextStyle(color: darkBlue),
                          ),
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.bottomRight,
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: resultText,
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  : null,
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
                onPressed: () async {
                  String key = keyString.toString();
                  String message = encrypt
                      ? await RSA.encryptPKCS1v15(eCon.text, key)
                      : await RSA.decryptPKCS1v15(dCon.text, key);
                  setState(() {
                    resultText = message;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
