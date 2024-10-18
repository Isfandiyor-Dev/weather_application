import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:weather_app/domain/entities/forecast_entity.dart';
part "weather_local_state.dart";

class WeatherCubit extends Cubit<LocalWeatherState> {
  final Box<ForecastEntity> forecastBox = Hive.box<ForecastEntity>('forecastBox');

  WeatherCubit() : super(LocalWeatherInitial());

  Future<void> saveForecastToLocalStorage(ForecastEntity forecast) async {
    emit(LocalWeatherSavingState());
    try {
      await forecastBox.put('selectedForecast', forecast);
      emit(LocalWeatherSavedState());
    } catch (e) {
      emit(LocalWeatherErrorState(e.toString()));
    }
  }

  void loadForecastFromLocalStorage() {
    emit(LocalWeatherLoadingState());
    try {
      final forecast = forecastBox.get('selectedForecast');
      if (forecast != null) {
        emit(LocalWeatherLoadedState(forecast));
      } else {
        emit(LocalWeatherEmptyState());
      }
    } catch (e) {
      emit(LocalWeatherErrorState(e.toString()));
    }
  }
}
