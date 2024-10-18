import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/extension/extensions_string.dart';
import 'package:weather_app/domain/entities/forecast_entity.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/presentation/blocs/location/location_bloc.dart';
import 'package:weather_app/presentation/blocs/weather/weather_bloc.dart';
import 'package:weather_app/presentation/cubits/favofites/favorite_forcasts_cubit.dart';
import 'package:weather_app/presentation/cubits/weather/weather_cubit.dart';
import 'package:weather_app/presentation/pages/home_page.dart';
import 'package:weather_app/presentation/widgets/search_initial_state_widget.dart';

class SearchPage extends StatefulWidget {
  final bool isIntro;
  const SearchPage({super.key, this.isIntro = false});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: () {
          BlocProvider.of<WeatherBloc>(context).add(ResetWeatherEvent());
          final locationState = BlocProvider.of<LocationBloc>(context).state;

          if (locationState is LocationPermissionGrantedState) {
            BlocProvider.of<LocationBloc>(context).add(GetCurrentLocationEvent());
          } else if (locationState is LocationLoadedState && locationState.locationData != null) {
            BlocProvider.of<WeatherBloc>(context).add(
              GetForecastByCoordEvent(
                locationState.locationData!.latitude!,
                locationState.locationData!.longitude!,
              ),
            );
          } else if (locationState is LocationPermissionDeniedState) {
            context.read<LocationBloc>().add(InitLocationEvent());
          } else {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text("Location data is not available. Please try again."),
                ),
              );
          }
        },
        child: const Icon(Icons.location_on_sharp),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 5,
          right: 15,
          top: 50,
        ),
        child: Column(
          children: [
            Row(
              children: [
                if (!widget.isIntro)
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<WeatherBloc>(context).add(ResetWeatherEvent());
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: textController,
                    onSubmitted: (value) {
                      BlocProvider.of<WeatherBloc>(context).add(GetForecastByCityEvent(textController.text.trim()));
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      hintText: "Enter city name",
                      suffixIcon: IconButton(
                        onPressed: () {
                          BlocProvider.of<WeatherBloc>(context).add(GetForecastByCityEvent(textController.text.trim()));
                        },
                        icon: const Icon(Icons.search_rounded),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoadingState) {
                  return const Center(child: CircularProgressIndicator.adaptive());
                } else if (state is WeatherFailureState) {
                  return Center(
                    child: Text((state).message),
                  );
                } else if (state is WeatherLoadedState) {
                  final forecast = state.forecastEntity;

                  if (forecast == null) {
                    return const Center(child: Text("Weather forecast data is not available."));
                  } else {
                    WeatherEntity weather = forecast.getCurrentWeather();
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<WeatherBloc>(context).add(ResetWeatherEvent());
                          context.read<WeatherCubit>().saveForecastToLocalStorage(forecast);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage(forecastEntity: forecast)),
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
                                Text(forecast.cityName),
                                Text(
                                  "${(weather.temp - 273.15).round()}℃",
                                )
                              ],
                            ),
                            subtitle: Text(weather.description.capitalizeFirstLetter()),
                            trailing: BlocBuilder<FavoritesCubit, List<ForecastEntity>>(
                              builder: (context, favorites) {
                                bool isFavorite = favorites.contains(forecast);
                                return IconButton(
                                  onPressed: () {
                                    if (isFavorite) {
                                      context.read<FavoritesCubit>().removeFavorite(forecast);
                                    } else {
                                      context.read<FavoritesCubit>().addFavorite(forecast);
                                    }
                                  },
                                  icon: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                } else {
                  return const SearchInitialStateWidget();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
