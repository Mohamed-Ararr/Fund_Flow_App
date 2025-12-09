// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BalanceEntryModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BalanceEntryModelAdapter extends TypeAdapter<BalanceEntryModel> {
  @override
  final int typeId = 10;

  @override
  BalanceEntryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BalanceEntryModel(
      amount: fields[0] as double,
      date: fields[1] as String,
      title: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BalanceEntryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BalanceEntryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
