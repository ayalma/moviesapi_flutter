import 'package:moviesapi_flutter/datasource/model/movie.dart';
import 'package:moviesapi_flutter/datasource/model/movie_list_response.dart';
import 'package:moviesapi_flutter/datasource/model/new_movie_request.dart';
import 'package:moviesapi_flutter/repository/movieRepository.dart';
import 'package:rxdart/rxdart.dart';

class MovieListBloc {
  int page = 1;
  bool hasMoreData = false;
  final MovieRepository repository;

  MovieListBloc(this.repository){
    fetchAllMovies();
  }

  var _movieList = List<Movie>();
  final _moviesSubject = BehaviorSubject<List<Movie>>();
  Observable<List<Movie>> get movies => _moviesSubject.stream;

  fetchAllMovies() async {

    var movieList = await repository.getMovieList(page).catchError((error){
      _moviesSubject.add(null);
      _moviesSubject.addError(error);
      return;
    });
    var currentpage = int.tryParse(movieList.metaData.currentPage);

    hasMoreData = currentpage < movieList.metaData.pageCount;
    page = currentpage+1;
    _movieList.addAll(movieList.data);
    print("loaded item = ${_movieList.length} and total count is : ${movieList.metaData.totalCount} \n "
          "current page is ${movieList.metaData.currentPage} and total page is ${movieList.metaData.pageCount}");
    _moviesSubject.sink.add(_movieList);
  }

  Future<List<Movie>> search(String pattern) => repository.search(pattern).then((item){
    return Future.value(item.data);
  });


  final _movieSubject = BehaviorSubject<Movie>();
  Observable<Movie> get movie => _movieSubject.stream;

  fetchMovie(int id) async {
    _movieSubject.add(null);
    var movie = await repository.getMovie(id).catchError((error){
      _movieSubject.addError(error);
    });
    _movieSubject.sink.add(movie);
  }

  dispose() {
    _movieSubject.close();
    _moviesSubject.close();
  }

  Future<NewMovieRequest> saveMove(NewMovieRequest request) async {
    print(request.toJson().toString());
    return repository.saveMovie(request);
  }
}
