import 'package:injectable/injectable.dart';
import 'package:weather_app/data/dataSources/remote/remote_service.dart';
import 'package:weather_app/data/repository/base/base_repository.dart';
import 'package:weather_app/domain/models/location_suggestion.dart';

@lazySingleton
final class LocationRepository extends BaseRepository {
  final RemoteService remoteService;

  LocationRepository({required this.remoteService});

  FutureState<List<LocationSuggestion>> getLocationSuggestions(String searchText) =>
      sendRemoteRequest(() => remoteService.getLocationSuggestions(searchText));
}
