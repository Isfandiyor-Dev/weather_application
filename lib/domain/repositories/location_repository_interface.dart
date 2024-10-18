import 'package:location/location.dart';

abstract class LocationRepositoryInterface {
  Future<bool> init();
  Future<LocationData?> getCurrentLocation();
}
