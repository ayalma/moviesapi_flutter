import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviesapi_flutter/datasource/api/movie_api.dart';
import 'package:moviesapi_flutter/datasource/model/movie.dart';
import 'package:moviesapi_flutter/datasource/model/movie_list_response.dart';
import 'package:moviesapi_flutter/main.dart';
import 'package:moviesapi_flutter/repository/movieRepository.dart';
import 'package:moviesapi_flutter/ui/movie_list_bloc.dart';
import 'package:moviesapi_flutter/ui/movie_page.dart';
import 'package:moviesapi_flutter/ui/movie_widget.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:moviesapi_flutter/ui/new_movie.dart';

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final MovieListBloc _bloc = getIt.get();
  final _searchKey = Key("search");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie api"),
        bottom: _buildSearchWidget(context),
      ),
      body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> data) {
          if (data.hasData) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                print(
                    "is index  $index  : ${index == data.data.length && _bloc.hasMoreData}");
                if (index == data.data.length && _bloc.hasMoreData) {
                  _bloc.fetchAllMovies();
                }
                return index < data.data.length
                    ? MovieWidget(
                        item: data.data[index],
                      )
                    : Center(child: CircularProgressIndicator());
              },
              itemCount: data.data.length + (_bloc.hasMoreData ? 1 : 0),
            );
          }
          if (data.hasError) {
            return Text("test");
          }

          return Container();
        },
        stream: _bloc.movies,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewMoviePage()),
          );
        },
        icon: Icon(Icons.movie_creation),
        label: Text("New Movie"),
      ),
    );
  }

  _buildSearchWidget(BuildContext context) {
    return PreferredSize(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: TypeAheadFormField(
          key: _searchKey,
          textFieldConfiguration: TextFieldConfiguration(
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              /* suffix: IconButton(icon: Icon(Icons.clear), onPressed: (){

              })*/
            ),
          ),
          suggestionsCallback: (pattern) async {
            return await _bloc.search(pattern);
          },
          itemBuilder: (context, suggestion) {
            final movie = suggestion as Movie;

            return Card(
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0),
                    ),
                    child: Container(
                      width: 96,
                      height: 96,
                      child: movie.images != null
                          ? CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: movie.images[0],
                              placeholder: Container(
                                  width: double.infinity,
                                  child: Center(
                                      child: CircularProgressIndicator())),
                              errorWidget: Container(
                                  width: double.infinity,
                                  child: Center(child: Icon(Icons.error))),
                            )
                          : Container(
                              child: Placeholder(),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Text(
                      movie.title,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ],
              ),
            );
            return Card(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Container(
                    width: 96,
                    height: 96,
                    child: movie.images != null
                        ? CachedNetworkImage(
                            imageUrl: movie.images[0],
                            placeholder: Container(
                                width: double.infinity,
                                child:
                                    Center(child: CircularProgressIndicator())),
                            errorWidget: Container(
                                width: double.infinity,
                                child: Center(child: Icon(Icons.error))),
                          )
                        : Container(
                            child: Placeholder(),
                          ),
                  ),
                ),
                title: Text(movie.title),
              ),
            );
          },
          onSuggestionSelected: (suggestion) {
            final movie = suggestion as Movie;
            //todo: show detail page
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MoviePage(
                    id: movie.id,
                  ),
            ));
          },
        ),
      ),
      preferredSize: Size(double.infinity, 56),
    );
  }
}
