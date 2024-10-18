import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'weather_entity.g.dart'; 

@HiveType(typeId: 2)
class WeatherEntity extends HiveObject with EquatableMixin {
  @HiveField(0)
  final DateTime dt;

  @HiveField(1)
  final double temp;

  @HiveField(2)
  final int humidity;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String icon;

  @HiveField(5)
  final int cloudsAll;

  @HiveField(6)
  final double windSpeed;

  @HiveField(7)
  final int visibility;

  WeatherEntity({
    required this.dt,
    required this.temp,
    required this.humidity,
    required this.description,
    required this.icon,
    required this.cloudsAll,
    required this.windSpeed,
    required this.visibility,
  });

  @override
  List<Object?> get props => [dt, temp, humidity, description, icon, cloudsAll, windSpeed, visibility];
}
