import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather_app/data/dataSources/remote/base/error_response.dart';
import 'package:weather_app/data/dataSources/remote/base/exceptions.dart';
import 'package:weather_app/data/dataSources/remote/remote_service.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/data/dataSources/remote/base/response_extensions.dart';
import 'package:weather_app/utils/helpers.dart';

typedef FutureState<T> = Future<State<T>>;

abstract base class BaseRepository {
  FutureState<T> sendRemoteRequest<T>(FutureResponse<T> Function() requestExecution) async {
    try {
      final response = await requestExecution();

      if (response.data != null) {
        return State.success(response.data!, message: 'Succeeded');
      } else {
        return State.failure(exception: DataNotFoundException());
      }
    } on DioException catch (exception) {
      printInDebug(exception);
      if (exception.response != null) {
        if (exception.response!.isUnauthorized) {
          return State.failure(exception: UnauthorizedException());
        } else if (exception.response is Map<String, dynamic>) {
          return State.failure(
              exception: null,
              message:
                  ErrorResponse.fromJson(exception.response as Map<String, dynamic>).error.message);
        } else {
          return State.failure();
        }
      } else {
        return State.failure();
      }
    }
  }
}
