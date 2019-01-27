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
      json['year'] as String,
      json['rated'] as String,
      json['released'] as String,
      json['runtime'] as String,
      json['director'] as String,
      json['writer'] as String,
      json['actors'] as String,
      json['plot'] as String,
      json['country'] as String,
      json['awards'] as String,
      json['metascore'] as String,
      json['imdb_rating'] as String,
      json['type'] as String,
      (json['genres'] as List)?.map((e) => e as String)?.toList(),
      (json['images'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'poster': instance.poster,
      'year': instance.year,
      'rated': instance.rated,
      'released': instance.released,
      'runtime': instance.runtime,
      'director': instance.director,
      'writer': instance.writer,
      'actors': instance.actors,
      'plot': instance.plot,
      'country': instance.country,
      'awards': instance.awards,
      'metascore': instance.metaScore,
      'imdb_rating': instance.imdbRating,
      'type': instance.type,
      'genres': instance.genres,
      'images': instance.images
    };
