import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:weather_app/domain/entities/forecast_entity.dart';

class FavoritesCubit extends Cubit<List<ForecastEntity>> {
  FavoritesCubit() : super(<ForecastEntity>[]) {
    loadFavorites();
  }

  final String _favoritesBox = 'favoritesBox';

  void loadFavorites() {
    var box = Hive.box<ForecastEntity>(_favoritesBox);
    emit(box.values.toList());
  }

  void addFavorite(ForecastEntity city) async {
    var box = Hive.box<ForecastEntity>(_favoritesBox);

    if (!box.values.any(
      (element) => (element.lat == city.lat) && (element.lon == city.lon),
    )) {
      final newCity = ForecastEntity(
        cityName: city.cityName,
        lat: city.lat,
        lon: city.lon,
        list: List.from(city.list),
      );
      await box.add(newCity);
      emit(box.values.toList());
    }
  }

  void removeFavorite(ForecastEntity city) async {
    var box = Hive.box<ForecastEntity>(_favoritesBox);
    await city.delete();
    emit(box.values.toList());
  }
}
