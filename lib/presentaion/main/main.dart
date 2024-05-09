import 'package:flutter/material.dart';
import 'package:weather_app/di/app_module.dart';
import 'package:weather_app/presentaion/location/location_choosing_screen.dart';
import 'package:weather_app/presentaion/main/router.dart';
import 'package:weather_app/presentaion/weather/current/current_weather_screen.dart';
import 'package:weather_app/utils/shared_preferences_manager.dart';

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
    return SafeArea(
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
