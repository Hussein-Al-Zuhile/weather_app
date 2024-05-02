import 'package:injectable/injectable.dart';
import 'package:weather_app/data/dataSources/remote/responses/current_weather_response.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/domain/base/base_use_case.dart';
import 'package:weather_app/domain/base/state.dart';

@injectable
final class GetCurrentWeatherUseCase extends RemoteUseCase<CurrentWeatherResponse> {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(super.connectionManager, this.weatherRepository);

  Stream<DomainState<CurrentWeatherResponse>> call(String locationName) =>
      execute(() => weatherRepository.getCurrentWeather(locationName));

}
