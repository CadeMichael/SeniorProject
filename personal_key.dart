
import 'package:flutter/material.dart';

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
  KeyPair ({
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
  @override
  Widget build(BuildContext context) {
    return const Text(
      "personal storage",
    );
  }
}
