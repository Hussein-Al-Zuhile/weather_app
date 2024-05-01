import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/domain/models/location.dart';
import 'package:weather_app/domain/models/weather_details.dart';

part 'current_weather_response.g.dart';

@JsonSerializable()
class CurrentWeatherResponse {
  final Location location;

  @JsonKey(name: 'current')
  final WeatherDetails weatherDetails;

  CurrentWeatherResponse({required this.location, required this.weatherDetails});

  factory CurrentWeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherResponseToJson(this);
}
