import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/di/app_module.dart';
import 'package:weather_app/domain/models/location_suggestion.dart';
import 'package:weather_app/presentaion/location/location_choosing_screen.dart';
import 'package:weather_app/presentaion/weather/current/current_weather_screen.dart';
import 'package:weather_app/utils/shared_preferences_manager.dart';

part 'router.g.dart';

final router = GoRouter(routes: $appRoutes);

@TypedGoRoute<CurrentWeatherRoute>(
    path: '/',
    routes: [TypedGoRoute<LocationChoosingRoute>(path: 'locationChoosing')])
@immutable
class CurrentWeatherRoute extends GoRouteData {
  const CurrentWeatherRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    SharedPreferencesManager sharedPreferencesManager = getIt();
    sharedPreferencesManager.getLocations().then((savedLocations) {
      if(savedLocations.isEmpty){
        LocationChoosingRoute().replace(context);
      }
    });
    return CurrentWeatherScreen();
  }
}

@immutable
class LocationChoosingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LocationChoosingScreen();
  }
}
