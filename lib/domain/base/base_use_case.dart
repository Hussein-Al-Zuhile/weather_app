import 'package:flutter/foundation.dart';
import 'package:weather_app/data/dataSources/remote/base/exceptions.dart';
import 'package:weather_app/data/repository/base/base_repository.dart';
import 'package:weather_app/domain/base/state.dart';
import 'package:weather_app/utils/connection_manager.dart';
import 'package:weather_app/utils/helpers.dart';

abstract base class UseCase {}

abstract base class RemoteUseCase<T> extends UseCase {
  final ConnectionManager _connectionManager;

  RemoteUseCase(this._connectionManager);

  Stream<DomainState<T>> execute(FutureState<T> Function() remoteRequest) async* {
    try {
      final isInternetAvailable = await _connectionManager.isInternetAvailable();

      if (!isInternetAvailable) {
        yield DomainState.failure(exception: NoInternetException());
        return;
      }

      yield DomainState.loading();

      final resultState = await remoteRequest();

      yield resultState;

    } on Exception catch (e) {
      printInDebug(e);
      yield DomainState.failure(exception: e);
    }
  }
}
