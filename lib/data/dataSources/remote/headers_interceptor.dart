import 'package:dio/dio.dart';

class HeadersInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({'key': 'bc619f0b16ba41f4aa873533242904'});
    super.onRequest(options, handler);
  }
}
