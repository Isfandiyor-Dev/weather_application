import 'package:weather_app/domain/repositories/location_repository_interface.dart';

class InitLocationUseCase {
  final LocationRepositoryInterface _locationRepository;
  InitLocationUseCase(this._locationRepository);

  Future<bool> call() async {
    try {
      return await _locationRepository.init();
    } catch (e) {
      rethrow;
    }
  }
}
