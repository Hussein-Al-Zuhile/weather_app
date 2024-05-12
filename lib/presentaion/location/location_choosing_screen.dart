import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/di/app_module.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/domain/models/location_suggestion.dart';
import 'package:weather_app/presentaion/location/current_location_cubit.dart';
import 'package:weather_app/presentaion/location/location_suggestions_cubit.dart';
import 'package:weather_app/presentaion/main/router.dart';
import 'package:weather_app/utils/extensions.dart';
import 'package:weather_app/utils/shared_preferences_manager.dart';

class LocationChoosingScreen extends StatelessWidget {
  LocationChoosingScreen({super.key});

  final SharedPreferencesManager sharedPreferencesManager = getIt();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurrentLocationCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => LocationSuggestionsCubit(getIt()),
        ),
      ],
      child: Stack(
        children: [
          GoRouter.of(context)
                  .routerDelegate
                  .currentConfiguration
                  .matches
                  .any((element) {
                    print(element);
            return (element as RouteMatch).route.path == "/";
          })
              ? IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.arrow_back))
              : Container(),
          BlocBuilder<CurrentLocationCubit, DomainState<Address>>(
            builder: (context, state) {
              if (state is Loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is Success<Address>) {
                final Ticker ticker = Ticker((elapsed) {
                  Future.delayed(const Duration(milliseconds: 500));
                });

                final TextEditingController searchFieldController =
                    TextEditingController(text: state.data.city ?? '');
                context
                    .read<LocationSuggestionsCubit>()
                    .getLocationSuggestions(state.data.city ?? '');

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      children: [
                    Text(
                      'Write down the city you want to check the weather of',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextField(
                      controller: searchFieldController,
                      onChanged: (value) {
                        context
                            .read<LocationSuggestionsCubit>()
                            .getLocationSuggestions(value);
                      },
                    ),
                    BlocBuilder<LocationSuggestionsCubit,
                        DomainState<List<LocationSuggestion>>>(
                      builder: (context, state) {
                        if (state is Loading) {
                          return const CircularProgressIndicator();
                        } else if (state is Success<List<LocationSuggestion>>) {
                          if (state.data.isNotEmpty) {
                            return ListView.separated(
                              itemBuilder: (context, index) {
                                final location = state.data[index];
                                return InkWell(
                                  onTap: () async {
                                    final currentLocations =
                                        await sharedPreferencesManager
                                            .getLocations();
                                    final distinctLocations = Set.of(
                                        currentLocations + [location.name]);
                                    await sharedPreferencesManager.setLocations(
                                        distinctLocations.toList());
                                    const CurrentWeatherRoute()
                                        .replace(context);
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            location.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          Text(location.country,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: state.data.length,
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                            );
                          } else {
                            return const Text('No Results Found');
                          }
                        } else {
                          return Container();
                        }
                      },
                    )
                  ].withSpaceBetween(height: 10)),
                );
              } else if (state is Failure) {
                return Text(state.message!);
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    ));
  }
}
