// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameHistoryAdapter extends TypeAdapter<GameHistory> {
  @override
  final int typeId = 0;

  @override
  GameHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameHistory(
      movesSAN: (fields[0] as List).cast<String>(),
      pgn: fields[1] as String,
      startedAt: fields[2] as DateTime,
      endedAt: fields[3] as DateTime,
      playerWhite: fields[4] as bool,
      vsAi: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GameHistory obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.movesSAN)
      ..writeByte(1)
      ..write(obj.pgn)
      ..writeByte(2)
      ..write(obj.startedAt)
      ..writeByte(3)
      ..write(obj.endedAt)
      ..writeByte(4)
      ..write(obj.playerWhite)
      ..writeByte(5)
      ..write(obj.vsAi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
