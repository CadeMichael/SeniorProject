import 'package:flutter/material.dart';

// @Crypt the widget tree that handles both encryption and
// decryption. It will need a text box to input text and a
// search bar to determine which public key to use.
class Crypt extends StatefulWidget {
  const Crypt({Key? key}) : super(key: key);
  @override
  State<Crypt> createState() => _CryptState();
}

class _CryptState extends State<Crypt> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "where cryptology happens",
    );
  }
}
