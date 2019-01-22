import 'package:flutter/material.dart';
import 'package:moviesapi_flutter/datasource/api/movie_api.dart';
import 'package:moviesapi_flutter/datasource/model/movie.dart';
import 'package:moviesapi_flutter/datasource/model/movie_list_response.dart';
import 'package:moviesapi_flutter/repository/movieRepository.dart';
import 'package:moviesapi_flutter/ui/movie_list_bloc.dart';
import 'package:moviesapi_flutter/ui/movie_widget.dart';

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final MovieListBloc _bloc = MovieListBloc(MovieRepository(MovieApi()));
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  _MovieListPageState() {
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie api"),
        actions: <Widget>[
        IconButton(
                 icon: Icon(Icons.shopping_cart),
                 tooltip: 'Open shopping cart',
                onPressed: () {
                  _bloc.fetchAllMovies();
                },
               ),
        ],
      ),
      body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> data) {
          if (data.hasData) {
            return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  print("is index  $index  : ${index == data.data.length && _bloc.hasMoreData}");
                  if(index == data.data.length && _bloc.hasMoreData)
                    {
                      _bloc.fetchAllMovies();
                    }
                  return index < data.data.length
                      ? MovieWidget(item: data.data[index],)
                      : Center(child:CircularProgressIndicator());
                },
                itemCount: data.data.length + (_bloc.hasMoreData ? 1 : 0),
                controller: _scrollController);
          }
          if (data.hasError) {
            return Text("test");
          }

          return Container();
        },
        stream: _bloc.movies,
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      //
    }
  }
}
