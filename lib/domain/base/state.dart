import 'package:weather_app/data/dataSources/remote/base/exceptions.dart';

sealed class State<T> {
  final String? message;

  State(this.message);

  factory State.initial({String? message}) => Initial<T>(message);

  factory State.loading({String? message}) => Loading<T>(message);

  factory State.success(T data, {String? message}) => Success<T>(data, message);

  factory State.failure({Exception? exception, String? message}) =>
      Failure<T>(exception, message: message);

  @override
  String toString() {
    return '$runtimeType, message: $message, exception: ${this is Failure ? (this as Failure).exception : 'null'}';
  }
}

class Initial<T> extends State<T> {
  Initial(super.message);
}

class Loading<T> extends State<T> {
  Loading(super.message);
}

class Refreshing<T> extends Loading<T> {
  Refreshing(super.message);
}

class Success<T> extends State<T> {
  final T data;

  Success(this.data, super.message);
}

class Failure<T> extends State<T> {
  final Exception? exception;

  Failure(this.exception, {String? message})
      : super(message ??
            ((exception != null && exception is CustomException && exception.message != null)
                ? exception.message!
                : 'An error has occurred'));
}
