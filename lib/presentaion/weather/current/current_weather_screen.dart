import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/dataSources/remote/responses/current_weather_response.dart';
import 'package:weather_app/di/app_module.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/presentaion/weather/current/current_weather_cubit.dart';

class CurrentWeatherScreen extends StatelessWidget {
  const CurrentWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrentWeatherCubit(getIt()),
      child: BlocBuilder<CurrentWeatherCubit, DomainState<CurrentWeatherResponse>>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Success<CurrentWeatherResponse>) {
            return Text(state.data.toString());
          } else {
            return const Placeholder();
          }
        },
      ),
    );
  }
}
