// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sight.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SightAdapter extends TypeAdapter<Sight> {
  @override
  final int typeId = 0;

  @override
  Sight read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sight(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as double,
      fields[5] as double,
      fields[6] as int,
      fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Sight obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.lat)
      ..writeByte(5)
      ..write(obj.lng)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SightAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sight _$SightFromJson(Map<String, dynamic> json) => Sight(
      (json['id'] as num).toInt(),
      json['title'] as String,
      json['description'] as String,
      json['address'] as String,
      (json['lat'] as num).toDouble(),
      (json['lng'] as num).toDouble(),
      (json['rating'] as num).toInt(),
      json['imageUrl'] as String,
    );

Map<String, dynamic> _$SightToJson(Sight instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'rating': instance.rating,
      'imageUrl': instance.imageUrl,
    };
