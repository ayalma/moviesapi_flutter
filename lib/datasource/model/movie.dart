import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable(nullable: false)
class Movie{
  final int id;
  final String title;
  final String poster;
  final List<String> genres;
  @JsonKey(nullable: true)
  final List<String> images;

  Movie(this.id, this.title, this.poster, this.genres, this.images);

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}