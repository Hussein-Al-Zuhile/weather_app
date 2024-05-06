import 'package:bloc/bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/domain/use_cases/location/get_current_location_use_case.dart';
import 'package:weather_app/utils/location_manager.dart';

@injectable
final class CurrentLocationCubit extends Cubit<DomainState<Address>> {
  final GetCurrentLocationUseCase getCurrentLocationUseCase;

  CurrentLocationCubit(this.getCurrentLocationUseCase) : super(DomainState.initial()) {
    getCurrentLocationUseCase().listen(emit);
  }

  void retry() => getCurrentLocationUseCase().listen(emit);
}
