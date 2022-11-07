// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FloorAdapter extends TypeAdapter<Floor> {
  @override
  final int typeId = 1;

  @override
  Floor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Floor(
      id: fields[0] as String,
      buildingId: fields[1] as String,
      name: fields[2] as String,
      flats: (fields[3] as List).cast<Flat>(),
    );
  }

  @override
  void write(BinaryWriter writer, Floor obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.buildingId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.flats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FloorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
