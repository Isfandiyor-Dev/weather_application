import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/entities/forecast_entity.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/presentation/blocs/weather/weather_bloc.dart';
import 'package:weather_app/presentation/cubits/weather/weather_cubit.dart';
import 'package:weather_app/presentation/pages/five_day_forecast.dart';
import 'package:weather_app/presentation/widgets/main_container.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  ForecastEntity forecastEntity;
  HomePage({
    super.key,
    required this.forecastEntity,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<WeatherBloc>().add(GetForecastByCityEvent(widget.forecastEntity.cityName));
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoadingState) {
                return buildWeatherUI(context, widget.forecastEntity);
              } else if (state is WeatherLoadedState) {
                widget.forecastEntity = state.forecastEntity!;
                context.read<WeatherCubit>().saveForecastToLocalStorage(widget.forecastEntity);
              }
              return buildWeatherUI(context, widget.forecastEntity);
            },
          ),
        ),
      ),
    );
  }

  Widget buildWeatherUI(BuildContext context, ForecastEntity forecastEntity) {
    final WeatherEntity weather = forecastEntity.getCurrentWeather();
    List<WeatherEntity> dailyForecast = forecastEntity.getDailyForecast();
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MainContainer(forecastEntity: forecastEntity, weather: weather),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return FiveDayForecast(forecast: forecastEntity.getFiveDayForecast());
                          },
                        ),
                      );
                    },
                    label: const Text("5 days"),
                    icon: const Icon(Icons.navigate_next_rounded),
                    iconAlignment: IconAlignment.end,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.14,
              child: ListView.builder(
                itemCount: dailyForecast.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) {
                  return Container(
                    width: 70,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color.fromARGB(255, 111, 163, 222),
                      border: Border.all(color: Theme.of(context).colorScheme.primary),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${(dailyForecast[index].temp - 273.15).round()} ℃",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Image.network(
                          "https://openweathermap.org/img/wn/${dailyForecast[index].icon}@2x.png",
                          width: 35,
                          height: 35,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox(
                              height: 35,
                            );
                          },
                        ),
                        Text(
                          DateFormat("HH:mm").format(dailyForecast[index].dt), // Corrected date format
                          style: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
