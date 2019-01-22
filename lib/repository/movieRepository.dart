import 'package:moviesapi_flutter/datasource/api/movie_api.dart';
import 'package:moviesapi_flutter/datasource/model/movie_list_response.dart';

class MovieRepository {
  final MovieApi movieApi;

  MovieRepository(this.movieApi);

  Future<MovieListResponse> getMovieList(int page) =>  movieApi.getMovieList(page);

  Future<MovieListResponse> search(String pattern) => movieApi.search(pattern);
}
