import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/data/dataSources/remote/responses/current_weather_response.dart';

typedef FutureResponse<T> = Future<Response<T>>;

@lazySingleton
class RemoteService {
  final Dio dio;

  RemoteService({required this.dio});

  FutureResponse<CurrentWeatherResponse> getCurrentWeather(String locationName) =>
      dio.get("current.json", queryParameters: {'q': locationName});
}
