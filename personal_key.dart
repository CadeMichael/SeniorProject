
import 'package:flutter/material.dart';

// @Personalkey is a modified listview to hold a user's keys
// it will hold public and private keys
// will need some popup for sharing public key
class PersonalKey extends StatefulWidget {
  const PersonalKey({Key? key}) : super(key: key);
  @override
  State<PersonalKey> createState() => _PersonalKeyState();
}

class _PersonalKeyState extends State<PersonalKey> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "personal storage",
    );
  }
}
