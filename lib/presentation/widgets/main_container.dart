import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/utils/extension/extensions_string.dart';
import 'package:weather_app/domain/entities/forecast_entity.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/presentation/widgets/custom_app_bar.dart';

class MainContainer extends StatelessWidget {
  final ForecastEntity forecastEntity;
  final WeatherEntity weather;
  const MainContainer({super.key, required this.forecastEntity, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: MediaQuery.of(context).size.height * 0.70,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40),
          bottom: Radius.circular(60),
        ),
        gradient: const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topRight,
          colors: [
            Color(0xFF497CF3),
            Color(0xFF53B9DB),
          ],
        ),
        border: Border.all(
          color: const Color.fromRGBO(146, 206, 255, 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlue.shade600,
            blurRadius: 50,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomAppBar(
            cityName: forecastEntity.cityName,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://openweathermap.org/img/wn/${weather.icon}@2x.png",
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox.shrink();
                    },
                  ),
                  Text(
                    "${weather.temp.round()} K",
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                weather.description.capitalizeFirstLetter(),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                DateFormat("EEEE, d MMMM").format(DateTime.now()),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade300,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  height: 50,
                  color: Colors.blue.shade300,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  propertyItemWeather(
                    CupertinoIcons.wind,
                    weather.windSpeed,
                    "Wind",
                  ),
                  propertyItemWeather(
                    CupertinoIcons.drop,
                    weather.humidity,
                    "Humidity",
                  ),
                  propertyItemWeather(
                    CupertinoIcons.cloud,
                    weather.cloudsAll,
                    "Clouds",
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget propertyItemWeather(IconData icon, dynamic unit, String name) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(height: 7),
        Text(
          "$unit",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          name,
          style: TextStyle(
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}
