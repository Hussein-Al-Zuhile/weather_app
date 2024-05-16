import 'package:bloc/bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/domain/use_cases/location/get_current_location_use_case.dart';
import 'package:weather_app/utils/location_manager.dart';
import 'package:weather_app/utils/shared_preferences_manager.dart';

@injectable
final class CurrentLocationCubit extends Cubit<DomainState<Address>> {
  final SharedPreferencesManager sharedPreferencesManager;
  final GetCurrentLocationUseCase getCurrentLocationUseCase;

  CurrentLocationCubit(this.getCurrentLocationUseCase, this.sharedPreferencesManager)
      : super(DomainState.initial()) {
    emit(DomainState.loading());
    sharedPreferencesManager.getLocations().then((savedLocations) {
      if (savedLocations.isEmpty) {
        getCurrentLocationUseCase().listen(emit);
      }else {
        emit(DomainState.success(Address()));
      }
    });
  }

  void retry() => getCurrentLocationUseCase().listen(emit);
}
