// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fast_session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FastSessionAdapter extends TypeAdapter<FastSession> {
  @override
  final int typeId = 0;

  @override
  FastSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FastSession(
      id: fields[0] as String,
      startTime: fields[1] as DateTime,
      endTime: fields[2] as DateTime?,
      planRatio: fields[3] as String,
      targetHours: fields[4] as int,
      completed: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FastSession obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.planRatio)
      ..writeByte(4)
      ..write(obj.targetHours)
      ..writeByte(5)
      ..write(obj.completed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FastSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
