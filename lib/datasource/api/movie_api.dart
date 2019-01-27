import 'package:http/http.dart' as http;
import 'package:moviesapi_flutter/config/app_cons.dart';
import 'package:moviesapi_flutter/datasource/model/movie.dart';
import 'dart:async';
import 'dart:convert';

import 'package:moviesapi_flutter/datasource/model/movie_list_response.dart';

class MovieApi{
  Future<MovieListResponse> getMovieList(int page) async{
      var res = await http.get(AppCons.baseUrl+"v1/movies?page=$page");
      return MovieListResponse.fromJson(json.decode(res.body));
  }

  Future<MovieListResponse> search(String pattern) async{
    var res = await http.get(AppCons.baseUrl+"v1/movies?q=$pattern&page=1");
    return MovieListResponse.fromJson(json.decode(res.body));
  }

  Future<Movie> getMovie(int id) async {
    var res = await http.get(AppCons.baseUrl+"v1/movies/$id");
    return Movie.fromJson(json.decode(res.body));
  }
}