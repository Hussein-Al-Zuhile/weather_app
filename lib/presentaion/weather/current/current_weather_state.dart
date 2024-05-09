import 'package:weather_app/data/dataSources/remote/responses/current_weather_response.dart';
import 'package:weather_app/domain/base/state.dart';

final class CurrentWeatherState {
  final Map<String, DomainState<CurrentWeatherResponse>> currentWeatherResponses;

  CurrentWeatherState(this.currentWeatherResponses);

  bool get isLoading =>
      currentWeatherResponses.isNotEmpty &&
      currentWeatherResponses.values.any((element) => element is Loading);

  bool get isSuccess =>
      currentWeatherResponses.isNotEmpty &&
      currentWeatherResponses.values.every((element) => element is Success<CurrentWeatherResponse>);
}
