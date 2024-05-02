import 'package:weather_app/data/dataSources/remote/base/exceptions.dart';

sealed class DomainState<T> {
  final String? message;

  DomainState({this.message});

  factory DomainState.initial({String? message}) => Initial<T>(message: message);

  factory DomainState.loading({String? message}) => Loading<T>(message: message);

  factory DomainState.success(T data, {String? message}) => Success<T>(data, message: message);

  factory DomainState.failure({Exception? exception, String? message}) =>
      Failure<T>(exception, message: message);

  @override
  String toString() {
    return '$runtimeType, message: $message, exception: ${this is Failure ? (this as Failure).exception : 'null'}';
  }
}

class Initial<T> extends DomainState<T> {
  Initial({super.message});
}

class Loading<T> extends DomainState<T> {
  Loading({super.message});
}

class Refreshing<T> extends Loading<T> {
  Refreshing({super.message});
}

class Success<T> extends DomainState<T> {
  final T data;

  Success(this.data, {super.message});
}

class Failure<T> extends DomainState<T> {
  final Exception? exception;

  Failure(this.exception, {String? message})
      : super(
            message: message ??
                ((exception != null && exception is CustomException && exception.message != null)
                    ? exception.message!
                    : 'An error has occurred'));
}
