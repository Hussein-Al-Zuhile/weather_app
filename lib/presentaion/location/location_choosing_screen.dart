import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/di/app_module.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/presentaion/location/current_location_cubit.dart';

class LocationChoosingScreen extends StatelessWidget {
  const LocationChoosingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: BlocProvider(
      create: (context) => CurrentLocationCubit(getIt()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Title(color: Colors.black, child: const Text('Your current location is')),
          BlocBuilder<CurrentLocationCubit, DomainState<Address>>(
            builder: (context, state) {
              if (state is Loading) {
                return const CircularProgressIndicator();
              } else if (state is Success<Address>) {
                return Text('City: ${state.data.city}');
              } else if (state is Failure) {
                return Text(state.message!);
              } else {
                return Placeholder();
              }
            },
          )
        ],
      ),
    ));
  }
}
