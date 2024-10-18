part of "weather_cubit.dart";

sealed class LocalWeatherState {}

final class LocalWeatherInitial extends LocalWeatherState {}

final class LocalWeatherSavingState extends LocalWeatherState {}

final class LocalWeatherSavedState extends LocalWeatherState {}

final class LocalWeatherLoadingState extends LocalWeatherState {}

final class LocalWeatherLoadedState extends LocalWeatherState {
  final ForecastEntity forecast;

  LocalWeatherLoadedState(this.forecast);
}

final class LocalWeatherEmptyState extends LocalWeatherState {}

final class LocalWeatherErrorState extends LocalWeatherState {
  final String message;

  LocalWeatherErrorState(this.message);
}
