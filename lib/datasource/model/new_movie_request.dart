import 'package:json_annotation/json_annotation.dart';

part 'new_movie_request.g.dart';

@JsonSerializable(nullable: true)
class NewMovieRequest{
  final int id;
  final String title;
  @JsonKey(name: "imdb_id")
  final String imdbId;
  final String country;
  final int year;
  final String director;
  @JsonKey(name: "imdb_rating")
  final String imdbRating;
  @JsonKey(name: "imdb_votes")
  final String imdbVotes;
  final String poster;

  NewMovieRequest(this.title, this.imdbId, this.country, this.year, this.director, this.imdbRating, this.imdbVotes, this.poster,{this.id});

  factory NewMovieRequest.fromJson(Map<String, dynamic> json) => _$NewMovieRequestFromJson(json);
  Map<String, dynamic> toJson() => _$NewMovieRequestToJson(this);
}
