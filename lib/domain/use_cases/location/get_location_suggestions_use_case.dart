import 'package:injectable/injectable.dart';
import 'package:weather_app/data/repository/location_repository.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/domain/base/base_use_case.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/domain/models/location_suggestion.dart';

@injectable
final class GetLocationSuggestionsUseCase extends RemoteUseCase<List<LocationSuggestion>> {
  final LocationRepository locationRepository;

  GetLocationSuggestionsUseCase(super.connectionManager, this.locationRepository);

  Stream<DomainState<List<LocationSuggestion>>> call(String searchText) =>
      execute(() => locationRepository.getLocationSuggestions(searchText));
}
