import 'package:dio/dio.dart';

final _dioOptions = BaseOptions(
    baseUrl: 'http://api.weatherapi.com/v1/',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10));

final dioSingleton = Dio(_dioOptions);
