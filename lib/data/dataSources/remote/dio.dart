import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/data/dataSources/remote/headers_interceptor.dart';

final _dioOptions = BaseOptions(
    baseUrl: 'http://api.weatherapi.com/v1/',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10));

@lazySingleton
Dio get dio => Dio(_dioOptions)
  ..interceptors
      .addAll([LogInterceptor(requestBody: true, responseBody: true), HeadersInterceptor()]);
