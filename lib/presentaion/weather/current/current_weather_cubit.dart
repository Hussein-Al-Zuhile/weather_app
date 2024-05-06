import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/data/dataSources/remote/responses/current_weather_response.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/domain/use_cases/weather/get_current_weather_use_case.dart';

class CurrentWeatherCubit extends Cubit<DomainState<CurrentWeatherResponse>> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  late final StreamSubscription subscription;

  CurrentWeatherCubit(this._getCurrentWeatherUseCase) : super(DomainState.initial()) {
    getCurrentWeatherDetails("");
  }

  void getCurrentWeatherDetails(String locationName) {
    subscription = _getCurrentWeatherUseCase(locationName).listen((state) {
      emit(state);
    });
  }

  void refresh() {
    _getCurrentWeatherUseCase("Damasc").listen((state) {
      emit(Refreshing());
      if (state is Success) {
        emit(state);
      }
    });
  }

  @override
  Future<void> close() async {
    subscription.cancel();
    super.close();
  }
}
