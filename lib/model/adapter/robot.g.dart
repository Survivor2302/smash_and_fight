// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../robot.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RobotAdapter extends TypeAdapter<Robot> {
  @override
  final int typeId = 1;

  @override
  Robot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Robot(
      name: fields[0] as String,
      sentence: fields[1] as String,
      attack: fields[2] as int,
      pv: fields[3] as int,
      speed: fields[4] as int,
      imageUrl: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Robot obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.sentence)
      ..writeByte(2)
      ..write(obj.attack)
      ..writeByte(3)
      ..write(obj.pv)
      ..writeByte(4)
      ..write(obj.speed)
      ..writeByte(5)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RobotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
