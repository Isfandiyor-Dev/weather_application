part of "weather_bloc.dart";

sealed class WeatherEvent {}

final class GetForecastByCityEvent extends WeatherEvent {
  final String city;
  GetForecastByCityEvent(this.city);
}

final class GetForecastByCoordEvent extends WeatherEvent {
  final double lat;
  final double lon;

  GetForecastByCoordEvent(this.lat, this.lon);
}

final class ResetWeatherEvent extends WeatherEvent {}
