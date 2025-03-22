import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/extension/extensions_string.dart';
import 'package:weather_app/domain/entities/forecast_entity.dart';
import '../../../domain/usecases/usecases.dart';
part "weather_event.dart";
part "weather_state.dart";

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetForecastByCityUseCase _getForecastByCityUseCase;
  final GetForecastByCoordUseCase _getForecastByCoordUseCase;
  WeatherBloc(
    this._getForecastByCityUseCase,
    this._getForecastByCoordUseCase,
  ) : super(WeatherInitialState()) {
    on<GetForecastByCityEvent>(_onGetForecastByCity);
    on<SearchForecastByCityEvent>(_onSearchForecastByCity);
    on<GetForecastByCoordEvent>(_onGetForecastByCoord);
    on<ResetWeatherEvent>(_onResetWeather);
  }

  void _onGetForecastByCity(GetForecastByCityEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingState());

    try {
      final forecast = await _getForecastByCityUseCase(event.city);
      emit(WeatherLoadedState(forecast));
    } catch (e) {
      emit(WeatherFailureState(e.toString().capitalizeFirstLetter()));
    }
  }

  void _onSearchForecastByCity(SearchForecastByCityEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingState());

    try {
      final forecast = await _getForecastByCityUseCase(event.searchCity);
      emit(WeatherLoadedSearchState(forecast));
    } catch (e) {
      emit(WeatherFailureState(e.toString().capitalizeFirstLetter()));
    }
  }

  void _onGetForecastByCoord(GetForecastByCoordEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingState());
    try {
      final forecast = await _getForecastByCoordUseCase(event.lat, event.lon);
      emit(WeatherLoadedState(forecast));
    } catch (e) {
      emit(WeatherFailureState(e.toString().capitalizeFirstLetter()));
    }
  }

  void _onResetWeather(ResetWeatherEvent event, Emitter<WeatherState> emit) {
    emit(WeatherInitialState());
  }
}
