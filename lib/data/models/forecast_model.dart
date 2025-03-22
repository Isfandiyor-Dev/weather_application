import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/domain/entities/forecast_entity.dart';

class ForecastModel {
  String cityName; // City name (String)
  double lat; // Latitude (degrees) (double)
  double lon; // Longitude (degrees) (double)
  List<WeatherModel> list; // List of weather data (List<WeatherModel>)

  ForecastModel({
    required this.cityName,
    required this.lat,
    required this.lon,
    required this.list,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cityName': cityName,
      'lat': lat,
      'lon': lon,
      'list': list.map((x) => x.toMap()).toList(),
    };
  }

  factory ForecastModel.fromMap(Map<String, dynamic> map) {
    return ForecastModel(
      cityName: map["city"]['name'] as String,
      lat: (map["city"]["coord"]['lat'] as num).toDouble(), // num -> double
      lon: (map["city"]["coord"]['lon'] as num).toDouble(), // num -> double
      list: List<WeatherModel>.from(
        (map['list'] as List).map<WeatherModel>(
          (x) => WeatherModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  ForecastEntity toEntity() {
    return ForecastEntity(
      cityName: cityName,
      lat: lat,
      lon: lon,
      list: list.map((e) => e.toEntity()).toList(),
    );
  }
}
