import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'weather_details.g.dart';

@JsonSerializable()
class WeatherDetails {
  @JsonKey(name: 'last_updated')
  final String lastUpdated;

  @JsonKey(name: 'temp_c')
  final num tempC;
  @JsonKey(name: 'temp_f')
  final num tempF;
  @JsonKey(name: 'is_day')
  final int isDay;
  @JsonKey(name: 'wind_kph')
  final num windKph;
  @JsonKey(name: 'wind_degree')
  final num windDegree;
  @JsonKey(name: 'wind_dir')
  final WindDirection windDir;

  WeatherDetails(
      {required this.lastUpdated,
      required this.tempC,
      required this.tempF,
      required this.isDay,
      required this.windKph,
      required this.windDegree,
      required this.windDir});

  factory WeatherDetails.fromJson(Map<String, dynamic> json) => _$WeatherDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDetailsToJson(this);
}

enum WindDirection {
  @JsonValue('N')
  north,
  @JsonValue('E')
  east,
  @JsonValue('S')
  south,
  @JsonValue('W')
  west,
}
