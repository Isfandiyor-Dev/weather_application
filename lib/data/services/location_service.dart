import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  bool _isServiceEnabled = false;
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  // Initialize the service and check permissions
  Future<bool> init() async {
    await _checkService();
    await _checkPermission();
    return _isServiceEnabled && _permissionStatus == PermissionStatus.granted;
  }

  // Check if location service is enabled
  Future<void> _checkService() async {
    try {
      _isServiceEnabled = await _location.serviceEnabled();

      if (!_isServiceEnabled) {
        _isServiceEnabled = await _location.requestService();
        if (!_isServiceEnabled) {
          throw Exception("Location service is disabled. Please enable it in settings.");
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  // Check if permission is granted
  Future<void> _checkPermission() async {
    try {
      _permissionStatus = await _location.hasPermission();

      if (_permissionStatus == PermissionStatus.denied) {
        _permissionStatus = await _location.requestPermission();
        if (_permissionStatus != PermissionStatus.granted) {
          throw Exception("Location permission is denied. Please grant permission in settings.");
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  // Get the current location
  Future<LocationData?> getCurrentLocation() async {
    try {
      if (_isServiceEnabled && _permissionStatus == PermissionStatus.granted) {
        return await _location.getLocation();
      }
      return null;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
