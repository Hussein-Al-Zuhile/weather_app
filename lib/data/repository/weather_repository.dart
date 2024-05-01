import 'package:injectable/injectable.dart';
import 'package:weather_app/data/dataSources/remote/remote_service.dart';
import 'package:weather_app/data/dataSources/remote/responses/current_weather_response.dart';
import 'package:weather_app/data/repository/base/base_repository.dart';
import 'package:weather_app/domain/base/state.dart';

@lazySingleton
final class WeatherRepository extends BaseRepository {
  final RemoteService remoteService;

  WeatherRepository(this.remoteService);

  FutureState<CurrentWeatherResponse> getCurrentWeather(String locationName) =>
      sendRemoteRequest(() => remoteService.getCurrentWeather(locationName));

}
