// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWeatherResponse _$CurrentWeatherResponseFromJson(
        Map<String, dynamic> json) =>
    CurrentWeatherResponse(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      weatherDetails:
          WeatherDetails.fromJson(json['current'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrentWeatherResponseToJson(
        CurrentWeatherResponse instance) =>
    <String, dynamic>{
      'location': instance.location,
      'current': instance.weatherDetails,
    };
