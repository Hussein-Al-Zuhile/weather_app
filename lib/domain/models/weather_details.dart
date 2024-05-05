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
  final Condition condition;

  late final Map<String, String> listOfData = {
    'Temperature in C': tempC.toString(),
    'Temperature in F': tempF.toString(),
    'Is Day': isDay.isOdd.toString(),
    'Wind in Kph': windKph.toString(),
  };

  WeatherDetails(
    this.condition, {
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.windKph,
    required this.windDegree,
  });

  factory WeatherDetails.fromJson(Map<String, dynamic> json) => _$WeatherDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDetailsToJson(this);
}

@JsonSerializable()
class Condition {
  final String text;
  final String icon;

  late final String iconUrl = 'https:$icon';

  Condition({required this.text, required this.icon});

  factory Condition.fromJson(Map<String, dynamic> json) =>
        _$ConditionFromJson(json);

    Map<String, dynamic> toJson() => _$ConditionToJson(this);
}
