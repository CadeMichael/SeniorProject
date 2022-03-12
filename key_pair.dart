import 'package:objectbox/objectbox.dart';

/// KeyPair holds the users personal key pairs
/// [keyName] is name of the individual pair ie, personal or work
/// [publicKey] is the public key
/// [privateKey] is the public key
/// [password] is the password for the private key
@Entity()
class KeyPair {
  // constructor
  KeyPair({
    required this.id,
    required this.keyName,
    required this.publicKey,
    required this.privateKey,
    required this.password,
    this.isExp = false,
  });

  // fields
  int id;
  String keyName;
  String publicKey;
  String privateKey;
  String password;
  @Transient()
  bool isExp;
}

