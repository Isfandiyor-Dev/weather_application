import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/extension/extensions_string.dart';
import 'package:weather_app/domain/entities/forecast_entity.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/presentation/cubits/favofites/favorite_forcasts_cubit.dart';
import 'package:weather_app/presentation/cubits/weather/weather_cubit.dart';
import 'package:weather_app/presentation/pages/home_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoritesCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sevimli Shaharlar'),
        ),
        body: BlocBuilder<FavoritesCubit, List<ForecastEntity>>(
          builder: (context, favorites) {
            return ListView.builder(
              itemCount: favorites.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final city = favorites[index];
                WeatherEntity weather = city.getCurrentWeather();
                return GestureDetector(
                  onTap: () {
                    context
                        .read<WeatherCubit>()
                        .saveForecastToLocalStorage(city);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(forecastEntity: city)),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Card(
                    child: ListTile(
                      leading: Image.network(
                        "https://openweathermap.org/img/wn/${weather.icon}@2x.png",
                        width: 45,
                        height: 45,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(city.cityName),
                          Text(
                            "${(weather.temp - 273.15).round()}℃",
                          )
                        ],
                      ),
                      subtitle:
                          Text(weather.description.capitalizeFirstLetter()),
                      trailing:
                          BlocBuilder<FavoritesCubit, List<ForecastEntity>>(
                        builder: (context, favorites) {
                          bool isFavorite = favorites.any((element) =>
                              (element.lat == city.lat) &&
                              (element.lon == city.lon));
                          return IconButton(
                            onPressed: () {
                              if (isFavorite) {
                                context
                                    .read<FavoritesCubit>()
                                    .removeFavorite(city);
                              } else {
                                context
                                    .read<FavoritesCubit>()
                                    .addFavorite(city);
                              }
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
