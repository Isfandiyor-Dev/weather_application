import 'package:location/location.dart';
import 'package:weather_app/domain/repositories/location_repository_interface.dart';

class GetCurrentLocationUseCase {
  final LocationRepositoryInterface _locationRepository;
  GetCurrentLocationUseCase(this._locationRepository);

  Future<LocationData?> call() async {
    try {
      return await _locationRepository.getCurrentLocation();
    } catch (e) {
      rethrow;
    }
  }
}
