import 'package:moviesapi_flutter/datasource/model/movie.dart';
import 'package:moviesapi_flutter/repository/movieRepository.dart';
import 'package:rxdart/rxdart.dart';

class MovieDataSource{
  int page = 1;
  bool hasMoreData = false;
  final MovieRepository repository;

  final _loadAfterStateSubject = BehaviorSubject<Object>();
  Observable<Object> get networkState => _loadAfterStateSubject.stream;

  var _movieList = List<Movie>();
  final _moviesSubject = BehaviorSubject<List<Movie>>();

  MovieDataSource(this.repository);
  Observable<List<Movie>> get movies => _moviesSubject.stream;

  loadInitial() async{
    var movieList = await repository.getMovieList(page).catchError((error){
      _moviesSubject.addError(error);
      return;
    });
    var currentpage = int.tryParse(movieList.metaData.currentPage);

    hasMoreData = currentpage < movieList.metaData.pageCount;
    page = currentpage+1;
    _movieList.addAll(movieList.data);
    _moviesSubject.sink.add(_movieList);
  }

  loadAfter() async{
    _loadAfterStateSubject.add(null);
    var movieList = await repository.getMovieList(page).catchError((error){
      _loadAfterStateSubject.add(error);
      return;
    });
    var currentpage = int.tryParse(movieList.metaData.currentPage);

    hasMoreData = currentpage < movieList.metaData.pageCount;
    page = currentpage+1;
    _movieList.addAll(movieList.data);
    _moviesSubject.sink.add(_movieList);
  }
}