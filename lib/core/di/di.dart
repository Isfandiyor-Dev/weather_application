import 'package:get_it/get_it.dart';
import 'package:weather_app/data/data_sources/remote_data_source/weather_data_source.dart';
import 'package:weather_app/data/repositories/location_repository.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/data/services/location_service.dart';
import '../../domain/usecases/usecases.dart';
import '../../presentation/blocs/blocs.dart';
import "../../presentation/cubits/cubits.dart";

final getIt = GetIt.instance;

void setUp() {
  //services
  getIt.registerSingleton<LocationService>(LocationService());

  //local_data_source
  getIt.registerSingleton<WeatherDataSource>(WeatherDataSource());

  //repositories
  getIt.registerSingleton<LocationRepository>(
    LocationRepository(locationService: getIt.get<LocationService>()),
  );
  getIt.registerSingleton<WeatherRepository>(
    WeatherRepository(weatherDataSource: getIt.get<WeatherDataSource>()),
  );

  // use cases
  getIt.registerFactory(() => InitLocationUseCase(getIt<LocationRepository>()));
  getIt.registerFactory(() => GetCurrentLocationUseCase(getIt<LocationRepository>()));
  getIt.registerFactory(() => GetForecastByCityUseCase(getIt<WeatherRepository>()));
  getIt.registerFactory(() => GetForecastByCoordUseCase(getIt<WeatherRepository>()));

  // bloc and cubits
  getIt.registerFactory(
    () => LocationBloc(
      getIt.get<GetCurrentLocationUseCase>(),
      getIt.get<InitLocationUseCase>(),
    ),
  );
  getIt.registerFactory(() => OnboardingCubit());
  getIt.registerFactory(() => WeatherCubit());
  getIt.registerFactory(() => FavoritesCubit());

  getIt.registerFactory(
    () => WeatherBloc(
      getIt.get<GetForecastByCityUseCase>(),
      getIt.get<GetForecastByCoordUseCase>(),
    ),
  );

  getIt.registerSingleton<ThemeModeCubit>(ThemeModeCubit());
}
