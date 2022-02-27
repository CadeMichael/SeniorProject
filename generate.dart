import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:openpgp/openpgp.dart';
import 'buttons.dart';

class Generate extends StatefulWidget {
  const Generate({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  KeyPair _keyPair = KeyPair("", "");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            TitleWidget(widget.title),
            ButtonWidget(
              title: "Generate",
              key: Key("action"),
              result: _keyPair.privateKey,
              onPressed: () async {
                var keyOptions = KeyOptions()..rsaBits = 2048;
                var keyPair = await OpenPGP.generate(
                    options: Options()
                      ..name = 'test'
                      ..email = 'test@test.com'
                      ..passphrase = 'test'
                      ..keyOptions = keyOptions);

                setState(() {
                  _keyPair = keyPair;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
