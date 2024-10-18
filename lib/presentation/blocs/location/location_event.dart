part of "location_bloc.dart";

sealed class LocationEvent {}

final class GetCurrentLocationEvent extends LocationEvent {}

final class InitLocationEvent extends LocationEvent {}
