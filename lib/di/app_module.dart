import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/dataSources/remote/dio.dart';
import 'package:weather_app/data/dataSources/remote/remote_service.dart';
import 'package:weather_app/di/app_module.config.dart';
import 'package:dio/dio.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

@module
abstract class AppModule {

  @lazySingleton
  RemoteService get remoteService => RemoteService(dio);

}
