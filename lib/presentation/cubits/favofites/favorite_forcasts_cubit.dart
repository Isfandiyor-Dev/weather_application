import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:weather_app/domain/entities/forecast_entity.dart';

class FavoritesCubit extends Cubit<List<ForecastEntity>> {
  FavoritesCubit() : super([]) {
    _loadFavorites();
  }

  final String _favoritesBox = 'favoritesBox';

  void _loadFavorites() {
    var box = Hive.box<ForecastEntity>(_favoritesBox);
    emit(box.values.toList());
  }

  void addFavorite(ForecastEntity city) async {
    var box = Hive.box<ForecastEntity>(_favoritesBox);
    if (!box.values.any((element) => element.cityName == city.cityName)) {
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
    await box.deleteAt(box.values.toList().indexOf(city));
    emit(box.values.toList());
  }
}
