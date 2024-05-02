import 'package:dio/dio.dart';

extension ResponseExtention<T> on Response<T> {
  bool get isSuccess => (statusCode ?? 0) >= 200 && (statusCode ?? 0) < 300;

  bool get isUnauthorized => statusCode == 401;

}
