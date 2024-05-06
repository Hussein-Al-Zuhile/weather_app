import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/data/dataSources/remote/base/exceptions.dart';
import 'package:weather_app/domain/base/state.dart';

@lazySingleton
class LocationManager {
  Future<DomainState<Address>> getLocation() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return DomainState.failure(exception: LocationServiceIsDisabled());
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.denied) {
        return DomainState.failure(exception: LocationPermissionsAreDenied());
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      return DomainState.failure(exception: LocationPermissionsArePermanentlyDenied());
    }

    final position = await Geolocator.getCurrentPosition();
    return Success(await GeoCode()
        .reverseGeocoding(latitude: position.latitude, longitude: position.longitude));
  }
}
