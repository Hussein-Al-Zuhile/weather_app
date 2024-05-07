import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/data/dataSources/remote/base/error_response.dart';
import 'package:weather_app/data/dataSources/remote/base/exceptions.dart';
import 'package:weather_app/data/dataSources/remote/remote_service.dart';
import 'package:weather_app/data/dataSources/remote/responses/current_weather_response.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/data/dataSources/remote/base/response_extensions.dart';
import 'package:weather_app/utils/helpers.dart';

typedef FutureState<T> = Future<DomainState<T>>;

abstract base class BaseRepository {

  @protected
  FutureState<T> sendRemoteRequest<T>(FutureResponse<T> Function() requestExecution) async {
    try {
      final response = await requestExecution();
      if (response.data != null) {
        return DomainState.success(response.data, message: 'Succeeded');
      } else {
        return DomainState.failure(exception: DataNotFoundException());
      }
    } on DioException catch (exception) {
      printInDebug(exception);
      if (exception.response != null) {
        if (exception.response!.isUnauthorized) {
          return DomainState.failure(exception: UnauthorizedException());
        } else if (exception.response is Map<String, dynamic>) {
          return DomainState.failure(
              exception: null,
              message:
                  ErrorResponse.fromJson(exception.response as Map<String, dynamic>).error.message);
        } else {
          return DomainState.failure();
        }
      } else {
        return DomainState.failure();
      }
    }
  }
}
