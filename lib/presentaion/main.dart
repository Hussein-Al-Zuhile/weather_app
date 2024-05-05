import 'package:flutter/material.dart';
import 'package:weather_app/di/app_module.dart';
import 'package:weather_app/presentaion/weather/current/current_weather_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        useMaterial3: true,
      ),
      home: SafeArea(child: CurrentWeatherScreen()),
    );
  }
}