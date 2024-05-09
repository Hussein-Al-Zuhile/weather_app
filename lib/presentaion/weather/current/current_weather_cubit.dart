import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/domain/use_cases/weather/get_current_weather_use_case.dart';
import 'package:weather_app/presentaion/weather/current/current_weather_state.dart';
import 'package:weather_app/utils/shared_preferences_manager.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  late final StreamSubscription subscription;
  final SharedPreferencesManager _sharedPreferencesManager;

  CurrentWeatherCubit(this._getCurrentWeatherUseCase, this._sharedPreferencesManager)
      : super(CurrentWeatherState({})) {
    _sharedPreferencesManager
        .getLocations()
        .then((savedLocations) => _getLocationsWeatherDetails(savedLocations));
  }


  @override
  Future<void> close() async {
    subscription.cancel();
    super.close();
  }

  _getLocationsWeatherDetails(List<String> savedLocations) {
    for (final location in savedLocations) {
      _getCurrentWeatherUseCase(location).listen((event) {
        emit(CurrentWeatherState(state.currentWeatherResponses..[location] = event));
      });
    }
  }
}
