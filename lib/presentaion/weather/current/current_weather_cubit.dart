import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/data/dataSources/remote/responses/current_weather_response.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/domain/use_cases/weather/get_current_weather_use_case.dart';

@injectable
class CurrentWeatherCubit extends Cubit<DomainState<CurrentWeatherResponse>> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  CurrentWeatherCubit(this.getCurrentWeatherUseCase) : super(DomainState.initial()) {
    getCurrentWeatherUseCase("Damascus").listen((state) {
      emit(state);
    });
  }

  void refresh() {
    getCurrentWeatherUseCase("Damascus").listen((state) {
      emit(Refreshing());
      if (state is Success) {
        emit(state);
      }
    });
  }
}
