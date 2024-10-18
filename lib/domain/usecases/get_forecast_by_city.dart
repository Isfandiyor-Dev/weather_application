import 'package:weather_app/domain/entities/forecast_entity.dart';
import 'package:weather_app/domain/repositories/weather_repository_interface.dart';

class GetForecastByCityUseCase {
  final WeatherRepositoryInterface _locationRepository;
  GetForecastByCityUseCase(this._locationRepository);

  Future<ForecastEntity?> call(String city) async {
    try {
      return await _locationRepository.getForecastByCity(city);
    } catch (e) {
      rethrow;
    }
  }
}
