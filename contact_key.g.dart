// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_key.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactKeyAdapter extends TypeAdapter<ContactKey> {
  @override
  final int typeId = 0;

  @override
  ContactKey read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactKey(
      contactName: fields[0] as String,
      publicKey: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ContactKey obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.contactName)
      ..writeByte(1)
      ..write(obj.publicKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactKeyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
