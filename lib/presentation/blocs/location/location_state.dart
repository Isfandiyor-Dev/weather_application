part of "location_bloc.dart";


sealed class LocationState {}

final class LocationInitialState extends LocationState {}

final class LocationLoadingState extends LocationState {}

final class LocationLoadedState extends LocationState {
  final LocationData? locationData;
  LocationLoadedState(this.locationData);
}

final class LocationFailureState extends LocationState {
  final String message;

  LocationFailureState(this.message);
}

final class LocationPermissionRequestingState extends LocationState {}

final class LocationPermissionDeniedState extends LocationState {}


final class LocationPermissionGrantedState extends LocationState {}
