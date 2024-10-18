import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/theme/dark_theme.dart';
import 'package:weather_app/core/utils/theme/light_theme.dart';
import 'package:weather_app/domain/entities/forecast_entity.dart';
import 'package:weather_app/presentation/blocs/location/location_bloc.dart';
import 'package:weather_app/presentation/pages/home_page.dart';
import 'package:weather_app/presentation/pages/onboarding_page.dart';
import '../../presentation/blocs/blocs.dart';
import "../../presentation/cubits/cubits.dart";

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    context.read<LocationBloc>().add(InitLocationEvent());
    context.read<WeatherCubit>().loadForecastFromLocalStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, bool>(
      builder: (context, themeState) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeState ? darkTheme : lightTheme,
          home: BlocBuilder<OnboardingCubit, bool>(
            builder: (context, onboardingState) {
              if (onboardingState) {
                return BlocBuilder<WeatherCubit, LocalWeatherState>(
                  builder: (context, weatherState) {
                    ForecastEntity? forecastEntity;
                    if (weatherState is LocalWeatherLoadedState) {
                      forecastEntity = weatherState.forecast;
                    }

                    if (forecastEntity != null) {
                      
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(forecastEntity: forecastEntity!),
                            ),
                          );
                        },
                      );

                      
                      return const SizedBox.shrink();
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                );
              } else {
                return const OnboardingPage();
              }
            },
          ),
        );
      },
    );
  }
}
