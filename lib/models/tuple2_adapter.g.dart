// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tuple2_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class Tuple2AdapterAdapter extends TypeAdapter<Tuple2Adapter> {
  @override
  final int typeId = 2;

  @override
  Tuple2Adapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tuple2Adapter()
      ..item1 = fields[0] as dynamic
      ..item2 = fields[1] as dynamic;
  }

  @override
  void write(BinaryWriter writer, Tuple2Adapter obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.item1)
      ..writeByte(1)
      ..write(obj.item2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tuple2AdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
