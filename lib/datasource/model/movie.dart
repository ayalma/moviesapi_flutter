import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable(nullable: true)
class Movie{
  final int id;
  final String title;
  final String poster;
  @JsonKey(nullable: true)
  final String year;
  @JsonKey(nullable: true)
  final String rated;

  @JsonKey(nullable: true)
  final String released;

  @JsonKey(nullable: true)
  final String runtime;

  @JsonKey(nullable: true)
  final String director;

  @JsonKey(nullable: true)
  final String writer;

  @JsonKey(nullable: true)
  final String actors;

  @JsonKey(nullable: true)
  final String plot;

  @JsonKey(nullable: true)
  final String country;

  @JsonKey(nullable: true)
  final String awards;

  @JsonKey(nullable: true,name: "metascore")
  final String metaScore;

  @JsonKey(nullable: true, name: 'imdb_rating')
  final String imdbRating;

  @JsonKey(nullable: true)
  final String type;


  final List<String> genres;
  @JsonKey(nullable: true)
  final List<String> images;

  Movie(this.id, this.title, this.poster, this.year, this.rated, this.released, this.runtime, this.director, this.writer, this.actors, this.plot, this.country, this.awards, this.metaScore, this.imdbRating, this.type, this.genres, this.images);

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

}
