import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/dataSources/remote/responses/current_weather_response.dart';
import 'package:weather_app/di/app_module.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/domain/models/weather_details.dart';
import 'package:weather_app/presentaion/base/widgets/error_widget.dart';
import 'package:weather_app/presentaion/weather/current/current_weather_cubit.dart';

class CurrentWeatherScreen extends StatelessWidget implements TickerProvider {
  const CurrentWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (context) => CurrentWeatherCubit(getIt()),
        child: BlocBuilder<CurrentWeatherCubit, DomainState<CurrentWeatherResponse>>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is Success<CurrentWeatherResponse>) {
              return WeatherDetailsWidget(weatherDetails: state.data.weatherDetails)
                  .animate(
                onPlay: (controller) =>
                    controller..loop(reverse: true, period: const Duration(seconds: 1)),
              )
                  .custom(builder: (context, value, child) {
                print(value);
                return Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.white, Colors.cyan, Colors.white],
                          stops: [0.0, 1 * value, 1.0])),
                  child: child,
                );
              });
            } else if (state is Failure<CurrentWeatherResponse>) {
              return ErrorPlaceholder(
                errorState: state,
                retry: () {
                  context.read<CurrentWeatherCubit>().getCurrentWeatherDetails("Damascus");
                },
              );
            } else {
              return const Placeholder();
            }
          },
        ),
      ),
    );
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}

class WeatherDetailsWidget extends StatelessWidget {
  final WeatherDetails weatherDetails;

  const WeatherDetailsWidget({super.key, required this.weatherDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Center(
            child: Text(
          weatherDetails.tempC.toString(),
          style: Theme.of(context).textTheme.displayLarge,
        )),
        const SizedBox(
          height: 20,
        ),
        Image.network(weatherDetails.condition.iconUrl),
        const SizedBox(
          height: 20,
        ),
        Text(
          weatherDetails.condition.text,
          style: Theme.of(context).textTheme.titleLarge,
        )
      ],
    );
  }
}
