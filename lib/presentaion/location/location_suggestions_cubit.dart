import 'package:bloc/bloc.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/domain/models/location_suggestion.dart';
import 'package:weather_app/domain/use_cases/location/get_location_suggestions_use_case.dart';

class LocationSuggestionsCubit
    extends Cubit<(LocationSuggestion?, DomainState<List<LocationSuggestion>>)> {
  final GetLocationSuggestionsUseCase getLocationSuggestionsUseCase;

  LocationSuggestionsCubit(this.getLocationSuggestionsUseCase)
      : super((null, DomainState.initial()));

  void getLocationSuggestions(String searchText) {
    getLocationSuggestionsUseCase(searchText)
        .listen((locationsState) => emit((null, locationsState)));
  }

  void updateSelectedLocation(LocationSuggestion? newLocationSelected) {
    emit((newLocationSelected, state.$2));
  }
}
