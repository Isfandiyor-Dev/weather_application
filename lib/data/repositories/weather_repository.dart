import 'package:weather_app/data/data_sources/remote_data_source/weather_data_source.dart';
import 'package:weather_app/data/models/forecast_model.dart';
import 'package:weather_app/domain/entities/forecast_entity.dart';
import 'package:weather_app/domain/repositories/weather_repository_interface.dart';

class WeatherRepository implements WeatherRepositoryInterface {
  final WeatherDataSource weatherDataSource;

  WeatherRepository({required this.weatherDataSource});

  @override
  Future<ForecastEntity?> getForecastByCity(String city) async {
    try {
      ForecastModel? forecast = await weatherDataSource.getForecastByCity(city);
      if (forecast != null) {
        return forecast.toEntity();
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  @override
  Future<ForecastEntity?> getForecastByCoord(double lat, double lon) async {
    try {
      ForecastModel? forecast = await weatherDataSource.getForecastByCoord(lat, lon);
      if (forecast != null) {
        return forecast.toEntity();
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
