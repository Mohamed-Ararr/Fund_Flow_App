// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SpentDetailModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpentDetailModelAdapter extends TypeAdapter<SpentDetailModel> {
  @override
  final int typeId = 4;

  @override
  SpentDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpentDetailModel(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SpentDetailModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.spentDetailTitle)
      ..writeByte(1)
      ..write(obj.spentDetailAmount)
      ..writeByte(2)
      ..write(obj.spentDetailDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpentDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
