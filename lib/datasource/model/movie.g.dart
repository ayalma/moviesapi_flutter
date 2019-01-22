// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
      json['id'] as int,
      json['title'] as String,
      json['poster'] as String,
      (json['genres'] as List).map((e) => e as String).toList(),
      (json['images'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'poster': instance.poster,
      'genres': instance.genres,
      'images': instance.images
    };
