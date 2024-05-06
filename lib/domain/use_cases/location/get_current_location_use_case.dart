import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/base/base_use_case.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/utils/location_manager.dart';

@injectable
final class GetCurrentLocationUseCase extends UseCase {
  final LocationManager locationManager;

  GetCurrentLocationUseCase({required this.locationManager});

  Stream<DomainState<Address>> call() async* {
    yield DomainState.loading();

    yield await locationManager.getLocation();
  }
}
