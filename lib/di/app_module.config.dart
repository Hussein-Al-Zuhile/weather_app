// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:weather_app/data/dataSources/remote/remote_service.dart' as _i5;
import 'package:weather_app/data/repository/weather_repository.dart' as _i6;
import 'package:weather_app/di/app_module.dart' as _i8;
import 'package:weather_app/domain/use_cases/weather/get_current_weather_use_case.dart'
    as _i7;
import 'package:weather_app/utils/connection_manager.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.singleton<_i3.ConnectionManager>(() => _i3.ConnectionManager());
    gh.lazySingleton<_i4.Dio>(() => appModule.dio);
    gh.lazySingleton<_i5.RemoteService>(
        () => _i5.RemoteService(dio: gh<_i4.Dio>()));
    gh.lazySingleton<_i6.WeatherRepository>(
        () => _i6.WeatherRepository(gh<_i5.RemoteService>()));
    gh.factory<_i7.GetCurrentWeatherUseCase>(() => _i7.GetCurrentWeatherUseCase(
          gh<_i3.ConnectionManager>(),
          gh<_i6.WeatherRepository>(),
        ));
    return this;
  }
}

class _$AppModule extends _i8.AppModule {}
