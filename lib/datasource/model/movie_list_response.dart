import 'package:json_annotation/json_annotation.dart';
import 'package:moviesapi_flutter/datasource/model/movie.dart';

part 'movie_list_response.g.dart';

@JsonSerializable(nullable: false)
class MovieListResponse{
  final List<Movie> data;
  @JsonKey(name: "metadata")
  final MetaData metaData;

  MovieListResponse(this.data, this.metaData);
  factory MovieListResponse.fromJson(Map<String, dynamic> json) => _$MovieListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MovieListResponseToJson(this);


}

@JsonSerializable(nullable: false)
class MetaData{
  @JsonKey(name: "current_page")
  final String currentPage;
  @JsonKey(name: "per_page")
  final int perPage;
  @JsonKey(name: "page_count")
  final int pageCount;
  @JsonKey(name: "total_count")
  final int totalCount;

  MetaData(this.currentPage, this.perPage, this.pageCount, this.totalCount);

  factory MetaData.fromJson(Map<String, dynamic> json) => _$MetaDataFromJson(json);
  Map<String, dynamic> toJson() => _$MetaDataToJson(this);


}