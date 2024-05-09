import 'package:bloc/bloc.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/domain/models/location_suggestion.dart';
import 'package:weather_app/domain/use_cases/location/get_location_suggestions_use_case.dart';

class LocationSuggestionsCubit extends Cubit<DomainState<List<LocationSuggestion>>> {
  final GetLocationSuggestionsUseCase getLocationSuggestionsUseCase;

  LocationSuggestionsCubit(this.getLocationSuggestionsUseCase) : super(DomainState.initial());

  void getLocationSuggestions(String searchText) {
    getLocationSuggestionsUseCase(searchText).listen(emit);
  }
}
