// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    ErrorResponse(
      ErrorBody.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
    };

ErrorBody _$ErrorBodyFromJson(Map<String, dynamic> json) => ErrorBody(
      json['message'] as String,
    );

Map<String, dynamic> _$ErrorBodyToJson(ErrorBody instance) => <String, dynamic>{
      'message': instance.message,
    };
