import 'dart:io';

sealed class CustomException implements Exception {
  final String? message;

  CustomException({this.message});
}

class NoInternetException implements CustomException {
  @override
  String? get message => "No internet connection, please check your connectivity.";
}

class DataNotFoundException implements CustomException {
  @override
  String? get message => "The response doesn't have data.";
}

class UnauthorizedException implements CustomException {
  @override
  String? get message => "The user is unauthorized.";
}
