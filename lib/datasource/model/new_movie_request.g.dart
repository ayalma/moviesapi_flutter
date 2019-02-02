// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_movie_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewMovieRequest _$NewMovieRequestFromJson(Map<String, dynamic> json) {
  return NewMovieRequest(
      json['title'] as String,
      json['imdb_id'] as String,
      json['country'] as String,
      json['year'] as int,
      json['director'] as String,
      json['imdb_rating'] as String,
      json['imdb_votes'] as String,
      json['poster'] as String,
      id: json['id'] as int);
}

Map<String, dynamic> _$NewMovieRequestToJson(NewMovieRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imdb_id': instance.imdbId,
      'country': instance.country,
      'year': instance.year,
      'director': instance.director,
      'imdb_rating': instance.imdbRating,
      'imdb_votes': instance.imdbVotes,
      'poster': instance.poster
    };
