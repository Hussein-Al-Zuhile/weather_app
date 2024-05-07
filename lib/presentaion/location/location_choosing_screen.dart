import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/di/app_module.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/domain/models/location_suggestion.dart';
import 'package:weather_app/presentaion/location/current_location_cubit.dart';
import 'package:weather_app/presentaion/location/location_suggestions_cubit.dart';

class LocationChoosingScreen extends StatelessWidget {
  const LocationChoosingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurrentLocationCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => LocationSuggestionsCubit(getIt()),
        ),
      ],
      child: BlocBuilder<CurrentLocationCubit, DomainState<Address>>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Success<Address>) {
            final Ticker ticker = Ticker((elapsed) {
              Future.delayed(const Duration(milliseconds: 500));
            });

            final TextEditingController searchFieldController =
                TextEditingController(text: state.data.city ?? '');
            context.read<LocationSuggestionsCubit>().getLocationSuggestions(state.data.city ?? '');

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Title(
                    color: Colors.black,
                    child: const Text('Write down the city you want to check the weather of')),
                TextField(
                  controller: searchFieldController,
                  expands: false,
                  onChanged: (value) {
                    context.read<LocationSuggestionsCubit>().getLocationSuggestions(value);
                  },
                ),
                BlocBuilder<LocationSuggestionsCubit,
                    (LocationSuggestion?, DomainState<List<LocationSuggestion>>)>(
                  builder: (context, state) {
                    LocationSuggestion? selectedLocation = state.$1;
                    DomainState<List<LocationSuggestion>> suggestionsState = state.$2;
                    if (suggestionsState is Loading) {
                      return const CircularProgressIndicator();
                    } else if (suggestionsState is Success<List<LocationSuggestion>>) {
                      final dropdownItems = suggestionsState.data
                          .map((location) => DropdownMenuItem(
                              value: location,
                              child: Column(
                                children: [
                                  Text(
                                    location.name,
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    location.country,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              )))
                          .toList();

                      if (dropdownItems.isNotEmpty) {
                        return DropdownButton(
                          items: dropdownItems,
                          onChanged: (value) {
                            context.read<LocationSuggestionsCubit>().updateSelectedLocation(value);
                          },
                          value: selectedLocation,
                          itemHeight: 66,
                        );
                      } else {
                        return const Text('No Results Found');
                      }
                    } else {
                      return const Placeholder();
                    }
                  },
                )
              ]),
            );
          } else if (state is Failure) {
            return Text(state.message!);
          } else {
            return Placeholder();
          }
        },
      ),
    ));
  }
}
