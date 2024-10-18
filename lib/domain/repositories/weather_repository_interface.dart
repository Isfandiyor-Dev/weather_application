import 'package:weather_app/domain/entities/forecast_entity.dart';

abstract class WeatherRepositoryInterface {
  Future<ForecastEntity?> getForecastByCity(String city);
  Future<ForecastEntity?> getForecastByCoord(double lat, double lon);
}
