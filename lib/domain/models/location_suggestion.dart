import 'package:json_annotation/json_annotation.dart';

part 'location_suggestion.g.dart';

@JsonSerializable()
class LocationSuggestion {
  final int id;
  final String name;
  final String country;
  final String region;
  final num lat;
  final num lon;
  final String url;

  LocationSuggestion(this.country,
      {required this.id,
      required this.name,
      required this.region,
      required this.lat,
      required this.lon,
      required this.url});

  factory LocationSuggestion.fromJson(Map<String, dynamic> json) =>
      _$LocationSuggestionFromJson(json);

  Map<String, dynamic> toJson() => _$LocationSuggestionToJson(this);
}
