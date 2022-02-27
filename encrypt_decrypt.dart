import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:openpgp/openpgp.dart';
import 'main.dart';
import 'buttons.dart';
import 'input_widget.dart';
import 'title_widget.dart';

class EncryptAndDecrypt extends StatefulWidget {
  const EncryptAndDecrypt({
    Key? key,
    required this.title,
    required KeyPair? keyPair,
  })  : keyPair = keyPair,
        super(key: key);

  final KeyPair? keyPair;
  final String title;

  @override
  _EncryptAndDecryptState createState() => _EncryptAndDecryptState();
}

class _EncryptAndDecryptState extends State<EncryptAndDecrypt> {
  String _encrypted = "";
  String _decrypted = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            TitleWidget(widget.title),
            InputWidget(
              title: "Encrypt",
              key: Key("encrypt"),
              result: _encrypted,
              onPressed: (controller) async {
                try {
                  log(controller.text);
                  log(widget.keyPair!.publicKey);
                  var encrypted = await OpenPGP.encrypt(
                    controller.text,
                    widget.keyPair!.publicKey,
                  );
                  log("test2");
                  setState(() {
                    _encrypted = encrypted;
                  });
                  log("test3");
                } catch (e) {
                  print(e);
                }
              },
            ),
            ButtonWidget(
              title: "Decrypt",
              key: Key("decrypt"),
              result: _decrypted,
              onPressed: () async {
                var decrypted = await OpenPGP.decrypt(
                  _encrypted,
                  widget.keyPair!.privateKey,
                  passphrase,
                );
                setState(() {
                  _decrypted = decrypted;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
