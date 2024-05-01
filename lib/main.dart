import 'package:flutter/material.dart';
import 'package:weather_app/di/app_module.dart';
import 'package:weather_app/domain/use_cases/weather/get_current_weather_use_case.dart';
import 'package:weather_app/utils/connection_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  GetCurrentWeatherUseCase(getIt(), getIt())("Damascus").listen((event) {
    print(event);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
