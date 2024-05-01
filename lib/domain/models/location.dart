import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String locationTime;

  Location({required this.name, required this.region, required this.country, required this.lat, required this.lon, required this.locationTime});

  factory Location.fromJson(Map<String, dynamic> json) =>
        _$LocationFromJson(json);

    Map<String, dynamic> toJson() => _$LocationToJson(this);
}
