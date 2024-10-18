import 'package:location/location.dart';
import 'package:weather_app/data/services/location_service.dart';
import 'package:weather_app/domain/repositories/location_repository_interface.dart';

class LocationRepository implements LocationRepositoryInterface {
  final LocationService locationService;
  LocationRepository({required this.locationService});

  @override
  Future<bool> init() async {
    try {
      return await locationService.init();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LocationData?> getCurrentLocation() async {
    try {
      return await locationService.getCurrentLocation();
    } catch (e) {
      rethrow;
    }
  }
}
