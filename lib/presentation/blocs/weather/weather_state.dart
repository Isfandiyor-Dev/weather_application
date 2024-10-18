part of "weather_bloc.dart";

sealed class WeatherState {}

final class WeatherInitialState extends WeatherState {}

final class WeatherLoadingState extends WeatherState {}

final class WeatherLoadedState extends WeatherState {
  final ForecastEntity? forecastEntity;
  WeatherLoadedState(this.forecastEntity);
}

final class WeatherFailureState extends WeatherState {
  final String message;

  WeatherFailureState(this.message);
}
