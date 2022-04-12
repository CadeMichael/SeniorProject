import 'package:hive/hive.dart';

/// KeyPair holds the users personal key pairs
/// [keyName] is name of the individual pair ie, personal or work
/// [publicKey] is the public key
/// [privateKey] is the public key
/// [password] is the password for the private key
@HiveType(typeId: 1)
class KeyPair extends HiveObject {
  // constructor
  KeyPair({
    required this.keyName,
    required this.publicKey,
    required this.privateKey,
    required this.password,
    this.isExp = false,
  });

  // fields
  @HiveField(0)
  String keyName;
  @HiveField(1)
  String publicKey;
  @HiveField(2)
  String privateKey;
  @HiveField(3)
  String password;
  bool isExp;
}
