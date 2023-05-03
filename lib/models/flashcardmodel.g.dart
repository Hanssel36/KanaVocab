// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcardmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlashcardModelAdapter extends TypeAdapter<FlashcardModel> {
  @override
  final int typeId = 1;

  @override
  FlashcardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FlashcardModel(
      frontText: fields[0] as String,
      backText: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FlashcardModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.frontText)
      ..writeByte(1)
      ..write(obj.backText);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlashcardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
