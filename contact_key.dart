import 'package:objectbox/objectbox.dart';

/// ContactKey holds the public Keys of your contacts
/// [contactName] is the contacts name
/// [publicKey] is their public key
@Entity()
class ContactKey {
  // constructor
  ContactKey({
    this.id = 0,
    required this.contactName,
    required this.publicKey,
    this.isExp = false,
  });

  // fields
  int id;
  String contactName;
  String publicKey;
  @Transient()
  bool isExp;
}
