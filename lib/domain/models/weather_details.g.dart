// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDetails _$WeatherDetailsFromJson(Map<String, dynamic> json) =>
    WeatherDetails(
      Condition.fromJson(json['condition'] as Map<String, dynamic>),
      lastUpdated: json['last_updated'] as String,
      tempC: json['temp_c'] as num,
      tempF: json['temp_f'] as num,
      isDay: (json['is_day'] as num).toInt(),
      windKph: json['wind_kph'] as num,
      windDegree: json['wind_degree'] as num,
    );

Map<String, dynamic> _$WeatherDetailsToJson(WeatherDetails instance) =>
    <String, dynamic>{
      'last_updated': instance.lastUpdated,
      'temp_c': instance.tempC,
      'temp_f': instance.tempF,
      'is_day': instance.isDay,
      'wind_kph': instance.windKph,
      'wind_degree': instance.windDegree,
      'condition': instance.condition,
    };

Condition _$ConditionFromJson(Map<String, dynamic> json) => Condition(
      text: json['text'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$ConditionToJson(Condition instance) => <String, dynamic>{
      'text': instance.text,
      'icon': instance.icon,
    };
