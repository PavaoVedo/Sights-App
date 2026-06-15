import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sight.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Sight {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String address;
  @HiveField(4)
  final double lat;
  @HiveField(5)
  final double lng;
  @HiveField(6)
  final int rating;
  @HiveField(7)
  final String imageUrl;

  Sight(
      this.id,
      this.title,
      this.description,
      this.address,
      this.lat,
      this.lng,
      this.rating,
      this.imageUrl,
      );

  // from JSON
  factory Sight.fromJson(Map<String, dynamic> json) => _$SightFromJson(json);

  // to JSON
  Map<String, dynamic> toJson() => _$SightToJson(this);
}