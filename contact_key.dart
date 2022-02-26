import 'package:hive/hive.dart';

/// ContactKey holds the public Keys of your contacts
/// [contactName] is the contacts name 
/// [publicKey] is their public key 
@HiveType(typeId: 0)
class ContactKey extends HiveObject{

  // constructor 
  ContactKey({
    required this.contactName,
    required this.publicKey,
    this.isExp = false,
  });

  // fields 
  @HiveField(0)
  String contactName;
  @HiveField(1)
  String publicKey;
  bool isExp;
}
