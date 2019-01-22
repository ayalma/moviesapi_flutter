// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieListResponse _$MovieListResponseFromJson(Map<String, dynamic> json) {
  return MovieListResponse(
      (json['data'] as List)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      MetaData.fromJson(json['metadata'] as Map<String, dynamic>));
}

Map<String, dynamic> _$MovieListResponseToJson(MovieListResponse instance) =>
    <String, dynamic>{'data': instance.data, 'metadata': instance.metaData};

MetaData _$MetaDataFromJson(Map<String, dynamic> json) {
  return MetaData(json['current_page'] as String, json['per_page'] as int,
      json['page_count'] as int, json['total_count'] as int);
}

Map<String, dynamic> _$MetaDataToJson(MetaData instance) => <String, dynamic>{
      'current_page': instance.currentPage,
      'per_page': instance.perPage,
      'page_count': instance.pageCount,
      'total_count': instance.totalCount
    };
