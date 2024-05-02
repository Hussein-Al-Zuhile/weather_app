// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDetails _$WeatherDetailsFromJson(Map<String, dynamic> json) =>
    WeatherDetails(
      lastUpdated: json['last_updated'] as String,
      tempC: json['temp_c'] as num,
      tempF: json['temp_f'] as num,
      isDay: (json['is_day'] as num).toInt(),
      windKph: json['wind_kph'] as num,
      windDegree: json['wind_degree'] as num,
      windDir: $enumDecode(_$WindDirectionEnumMap, json['wind_dir']),
    );

Map<String, dynamic> _$WeatherDetailsToJson(WeatherDetails instance) =>
    <String, dynamic>{
      'last_updated': instance.lastUpdated,
      'temp_c': instance.tempC,
      'temp_f': instance.tempF,
      'is_day': instance.isDay,
      'wind_kph': instance.windKph,
      'wind_degree': instance.windDegree,
      'wind_dir': _$WindDirectionEnumMap[instance.windDir]!,
    };

const _$WindDirectionEnumMap = {
  WindDirection.north: 'N',
  WindDirection.east: 'E',
  WindDirection.south: 'S',
  WindDirection.west: 'W',
  WindDirection.northWest: 'NW',
  WindDirection.northEast: 'NE',
  WindDirection.southWest: 'SW',
  WindDirection.southEast: 'SE',
};
