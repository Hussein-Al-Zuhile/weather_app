import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/data/dataSources/remote/responses/current_weather_response.dart';
import 'package:weather_app/di/app_module.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/domain/models/location_suggestion.dart';
import 'package:weather_app/domain/models/weather_details.dart';
import 'package:weather_app/presentaion/base/widgets/circle_indicator.dart';
import 'package:weather_app/presentaion/base/widgets/error_widget.dart';
import 'package:weather_app/presentaion/main/router.dart';
import 'package:weather_app/presentaion/weather/current/current_weather_cubit.dart';
import 'package:weather_app/presentaion/weather/current/current_weather_state.dart';

class CurrentWeatherScreen extends StatelessWidget implements TickerProvider {
  CurrentWeatherScreen({super.key});

  final PageController pageController = PageController();
  var currentPage = 0;

  void onPageChanged(pageIndex) => currentPage = pageIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CurrentWeatherCubit(getIt(), getIt()),
        child: BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
          builder: (context, currentWeatherState) {
            return Stack(
              children: [
                PageView(
                  controller: pageController,
                  allowImplicitScrolling: true,
                  onPageChanged: onPageChanged,
                  children: currentWeatherState.currentWeatherResponses.values
                      .map((e) => WeatherPage(state: e))
                      .toList(),
                )
                    .animate(
                  onPlay: (controller) =>
                      controller..loop(reverse: true, period: const Duration(seconds: 3)),
                )
                    .custom(builder: (context, value, child) {
                  return Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: const [Colors.white, Colors.cyan, Colors.white],
                            stops: [0.0, 1 * value, 1.0])),
                    child: child,
                  );
                }),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: currentWeatherState.currentWeatherResponses.values.indexed
                        .map((weatherDetails) => Builder(builder: (context) {
                              final circleIndicator = CircleIndicator();
                              if (weatherDetails.$1 == 0) {
                                circleIndicator.isSelected.value = true;
                              }
                              pageController.addListener(() {
                                circleIndicator.isSelected.value = weatherDetails.$1 == currentPage;
                              });
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
                                  onTap: () {
                                    pageController.animateToPage(weatherDetails.$1,
                                        duration: const Duration(milliseconds: 200),
                                        curve: Curves.bounceIn);
                                  },
                                  child: CustomPaint(
                                      painter: circleIndicator, size: const Size(20, 20)),
                                ),
                              );
                            }))
                        .toList(),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_back))
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          LocationChoosingRoute().go(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key, required this.state});

  final DomainState<CurrentWeatherResponse> state;

  @override
  Widget build(BuildContext context) {
    if (state is Loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is Success<CurrentWeatherResponse>) {
      return WeatherDetailsWidget(
          currentWeatherResponse: (state as Success<CurrentWeatherResponse>).data);
    } else if (state is Failure<CurrentWeatherResponse>) {
      return ErrorPlaceholder(
        errorState: (state as Failure<CurrentWeatherResponse>),
        retry: () {
          /*TODO*/
        },
      );
    } else {
      return Column(
        children: [
          Title(color: Colors.black, child: const Text("@#!@##@!")),
          Container(),
        ],
      );
    }
  }
}

class WeatherDetailsWidget extends StatelessWidget {
  final CurrentWeatherResponse currentWeatherResponse;

  const WeatherDetailsWidget({super.key, required this.currentWeatherResponse});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          currentWeatherResponse.location.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Center(
            child: Text(
          currentWeatherResponse.weatherDetails.tempC.toString(),
          style: Theme.of(context).textTheme.displayLarge,
        )),
        const SizedBox(
          height: 20,
        ),
        Image.network(currentWeatherResponse.weatherDetails.condition.iconUrl),
        const SizedBox(
          height: 20,
        ),
        Text(
          currentWeatherResponse.weatherDetails.condition.text,
          style: Theme.of(context).textTheme.titleLarge,
        )
      ],
    );
  }
}
