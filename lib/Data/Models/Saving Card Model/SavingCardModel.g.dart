// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SavingCardModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavingCardModelAdapter extends TypeAdapter<SavingCardModel> {
  @override
  final int typeId = 1;

  @override
  SavingCardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavingCardModel(
      title: fields[0] as String?,
      savingGoal: fields[1] as double?,
      currentSaving: fields[2] as double?,
      isCompleted: fields[3] as bool?,
      lastSeen: fields[4] as String?,
      createdDate: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SavingCardModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.savingGoal)
      ..writeByte(2)
      ..write(obj.currentSaving)
      ..writeByte(3)
      ..write(obj.isCompleted)
      ..writeByte(4)
      ..write(obj.lastSeen)
      ..writeByte(5)
      ..write(obj.createdDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavingCardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
