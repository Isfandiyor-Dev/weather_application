import 'package:dio/dio.dart';
import 'package:weather_app/data/models/forecast_model.dart';

class WeatherDataSource {
  late final Dio _dio;
  final String _apiKey = "59a46a2833b5e2202cc3fc83a4ac8f78";

  WeatherDataSource() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://api.openweathermap.org/data/2.5/forecast?",
      ),
    );
  }

  String errorMessage(DioException e) {
    return e.response?.data["message"] ?? "No internet connection.";
  }

  Future<ForecastModel?> getForecastByCity(String city) async {
    String url = "q=$city&appid=$_apiKey";
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return ForecastModel.fromMap(response.data);
      } else {
        throw "An error occurred, error code: ${response.statusCode}.";
      }
    } on DioException catch (e) {
      throw errorMessage(e);
    } catch (e) {
      throw "Something went wrong, please try again.";
    }
  }

  Future<ForecastModel?> getForecastByCoord(double lat, double lon) async {
    String url = "lat=$lat&lon=$lon&appid=$_apiKey";
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return ForecastModel.fromMap(response.data);
      } else {
        throw "An error occurred, error code: ${response.statusCode}.";
      }
    } on DioException catch (e) {
      throw errorMessage(e);
    } catch (e) {
      throw "Something went wrong, please try again.";
    }
  }
}
