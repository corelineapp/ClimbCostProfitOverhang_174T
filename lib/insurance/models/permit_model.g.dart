// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permit_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PermitAdapter extends TypeAdapter<Permit> {
  @override
  final int typeId = 0;

  @override
  Permit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Permit(
      type: fields[0] as String,
      amount: fields[1] as double,
      expiryDate: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Permit obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.expiryDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PermitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
