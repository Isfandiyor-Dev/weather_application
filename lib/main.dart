import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/core/app/main_app.dart';
import 'package:weather_app/core/di/di.dart';
import 'package:weather_app/data/repositories/location_repository.dart';
import 'package:weather_app/domain/entities/forecast_entity.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'presentation/blocs/blocs.dart';
import "presentation/cubits/cubits.dart";


void main() async {
  await Hive.initFlutter();

  await Hive.openBox('themeBox');
  await Hive.openBox('onboardingBox');
  Hive.registerAdapter(ForecastEntityAdapter());
  Hive.registerAdapter(WeatherEntityAdapter());
  await Hive.openBox<ForecastEntity>('forecastBox');
  await Hive.openBox<ForecastEntity>('favoritesBox');

  setUp();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => getIt.get<LocationRepository>(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt.get<LocationBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt.get<ThemeModeCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt.get<WeatherBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt.get<WeatherCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt.get<FavoritesCubit>(),
          ),
          BlocProvider(create: (_) => getIt.get<OnboardingCubit>()..loadOnboardingStatus()),
        ],
        child: const MainApp(),
      ),
    ),
  );
}
