/// ContactKey holds the public Keys of your contacts
/// [contactName] is the contacts name
/// [publicKey] is their public key
class ContactKey {
  // constructor
  ContactKey({
    required this.contactName,
    required this.publicKey,
    this.isExp = false,
  });

  // fields
  String contactName;
  String publicKey;
  bool isExp;
}
