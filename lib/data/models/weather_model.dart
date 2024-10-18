import 'package:weather_app/domain/entities/weather_entity.dart';

class WeatherModel {
  DateTime dt; // Date and time (milliseconds since epoch) (DateTime)
  double temp; // Temperature (Kelvin) (double)
  int humidity; // Humidity (%) (int)
  String description; // Weather description (String)
  String icon; // Weather icon code (String)
  int cloudsAll; // Cloudiness (%) (int)
  double windSpeed; // Wind speed (meters/second) (double)
  int visibility; // Visibility (meters) (int)

  WeatherModel({
    required this.dt,
    required this.temp,
    required this.humidity,
    required this.description,
    required this.icon,
    required this.cloudsAll,
    required this.windSpeed,
    required this.visibility,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dt': dt.millisecondsSinceEpoch,
      'temp': temp,
      'humidity': humidity,
      'description': description,
      'icon': icon,
      'clouds': cloudsAll,
      'wind': windSpeed,
      'visibility': visibility,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      dt: DateTime.fromMillisecondsSinceEpoch(map['dt']*1000 as int),
      temp: (map["main"]['temp'] as num).toDouble(),
      humidity: map["main"]['humidity'] as int,
      description: (map["weather"][0]['description'] as String),
      icon: (map["weather"][0]['icon'] as String),
      cloudsAll: map['clouds']["all"] as int,
      windSpeed: (map['wind']["speed"] as num).toDouble(),
      visibility: map['visibility'] as int,
    );
  }

  WeatherEntity toEntity() {
    return WeatherEntity(
      dt: dt,
      temp: temp,
      humidity: humidity,
      description: description,
      icon: icon,
      cloudsAll: cloudsAll,
      windSpeed: windSpeed,
      visibility: visibility,
    );
  }
}
