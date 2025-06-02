// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SpentCardModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpentCardModelAdapter extends TypeAdapter<SpentCardModel> {
  @override
  final int typeId = 0;

  @override
  SpentCardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpentCardModel(
      fields[0] as String?,
      fields[1] as double?,
      fields[2] as String?,
      (fields[3] as List?)?.cast<SpentDetailModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, SpentCardModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.spentAmount)
      ..writeByte(2)
      ..write(obj.lastUpdate)
      ..writeByte(3)
      ..write(obj.spentsList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpentCardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
