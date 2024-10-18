import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';

class FiveDayForecast extends StatelessWidget {
  final List<WeatherEntity> forecast;
  const FiveDayForecast({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('5-Day Forecast'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: forecast.length,
          itemBuilder: (context, index) {
            final weather = forecast[index];
            final dayOfWeek = DateFormat('E').format(weather.dt);

            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dayOfWeek,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Image.network(
                        "https://openweathermap.org/img/wn/${weather.icon}@2x.png",
                        width: 35,
                        height: 35,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox.shrink();
                        },
                      ),
                      const SizedBox(width: 10),
                      Text(
                        weather.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Text(
                    "${(weather.temp - 273.15).round()}℃",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
