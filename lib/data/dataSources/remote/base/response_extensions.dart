import 'package:dio/dio.dart';

extension ResponseExtention on Response {
  bool get isSuccess => (statusCode ?? 0) >= 200 && (statusCode ?? 0) < 300;

  bool get isUnauthorized => statusCode == 401;
}
