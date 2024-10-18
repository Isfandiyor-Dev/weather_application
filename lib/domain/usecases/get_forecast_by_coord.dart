import 'package:weather_app/domain/entities/forecast_entity.dart';
import 'package:weather_app/domain/repositories/weather_repository_interface.dart';

class GetForecastByCoordUseCase {
  final WeatherRepositoryInterface _locationRepository;
  GetForecastByCoordUseCase(this._locationRepository);

  Future<ForecastEntity?> call(double lat, double lon) async {
    try {
      return await _locationRepository.getForecastByCoord(lat, lon);
    } catch (e) {
      rethrow;
    }
  }
}
