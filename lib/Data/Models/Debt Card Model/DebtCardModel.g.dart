// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DebtCardModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DebtCardModelAdapter extends TypeAdapter<DebtCardModel> {
  @override
  final int typeId = 2;

  @override
  DebtCardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DebtCardModel(
      title: fields[0] as String,
      amount: fields[1] as double,
      date: fields[2] as String,
      isDebt: fields[3] as bool,
      isPaid: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, DebtCardModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.isDebt)
      ..writeByte(4)
      ..write(obj.isPaid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebtCardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
