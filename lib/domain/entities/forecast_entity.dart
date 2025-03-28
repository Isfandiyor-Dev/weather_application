// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'weather_entity.dart';

part 'forecast_entity.g.dart';

@HiveType(typeId: 1)
class ForecastEntity extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String cityName;

  @HiveField(1)
  final double lat;

  @HiveField(2)
  final double lon;

  @HiveField(3)
  final List<WeatherEntity> list;

  ForecastEntity({
    required this.cityName,
    required this.lat,
    required this.lon,
    required this.list,
  });

  @override
  List<Object?> get props => [cityName, lat, lon, list];

  WeatherEntity getCurrentWeather() {
    final currentTime = DateTime.now();
    return list.firstWhere(
      (weather) => weather.dt.isAfter(currentTime),
      orElse: () => list.first,
    );
  }

  List<WeatherEntity> getDailyForecast() {
    return list.take(8).toList();
  }

  List<WeatherEntity> getFiveDayForecast() {
    List<WeatherEntity> days = [];
    DateTime targetDt = DateTime(list.first.dt.year, list.first.dt.month, list.first.dt.day);

    for (var element in list) {
      DateTime elementDate = DateTime(element.dt.year, element.dt.month, element.dt.day);
      if (elementDate.isAfter(targetDt)) {
        days.add(element);
        targetDt = elementDate;
      }
    }

    return days;
  }
}
