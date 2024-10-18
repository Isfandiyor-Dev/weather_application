// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForecastEntityAdapter extends TypeAdapter<ForecastEntity> {
  @override
  final int typeId = 1;

  @override
  ForecastEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForecastEntity(
      cityName: fields[0] as String,
      lat: fields[1] as double,
      lon: fields[2] as double,
      list: (fields[3] as List).cast<WeatherEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, ForecastEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.cityName)
      ..writeByte(1)
      ..write(obj.lat)
      ..writeByte(2)
      ..write(obj.lon)
      ..writeByte(3)
      ..write(obj.list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
