import 'package:moviesapi_flutter/datasource/api/movie_api.dart';
import 'package:moviesapi_flutter/datasource/model/movie.dart';
import 'package:moviesapi_flutter/datasource/model/movie_list_response.dart';
import 'package:moviesapi_flutter/datasource/model/new_movie_request.dart';

class MovieRepository {
  final MovieApi movieApi;

  MovieRepository(this.movieApi);

  Future<MovieListResponse> getMovieList(int page) =>  movieApi.getMovieList(page);

  Future<MovieListResponse> search(String pattern) => movieApi.search(pattern);

  Future<Movie> getMovie(int id) => movieApi.getMovie(id);

  Future<NewMovieRequest> saveMovie(NewMovieRequest request) => movieApi.saveMovie(request);
}
