
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviesapi_flutter/config/localizations.dart';
import 'package:moviesapi_flutter/datasource/model/movie.dart';
import 'package:moviesapi_flutter/main.dart';
import 'package:moviesapi_flutter/ui/loading_view.dart';
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
  final _searchCtrl = TextEditingController();
  FocusNode _searchField;
  @override
  void initState() {
    // TODO: implement initState
    _searchField = FocusNode();
    _bloc.datasource.loadInitial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 120),
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(32),bottomLeft: Radius.circular(32),),
          child: AppBar(
            title: Text(AppLocalizations.of(context).movieApi),
            bottom: _buildSearchWidget(context),
          ),
        ),
      ),
      body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> data) {
          if (data.hasData) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                print(
                    "is index  $index  : ${index == data.data.length && _bloc.datasource.hasMoreData}");
                if (index == data.data.length && _bloc.datasource.hasMoreData) {
                  _bloc.datasource.loadAfter();
                }
                return index < data.data.length
                    ? MovieWidget(
                  item: data.data[index],
                )
                    : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder(
                        builder: (context, AsyncSnapshot<Object> item) {
                          if (item.hasData) {
                            return LoadingView(
                              onPressed: () {
                                _bloc.datasource.loadAfter();
                              },
                              error: item.data,
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                        stream: _bloc.datasource.networkState,
                      ),
                    ));
              },
              itemCount:
              data.data.length + (_bloc.datasource.hasMoreData ? 1 : 0),
            );
          }
          if (data.hasError) {
            return LoadingView(
              onPressed: () {
                _bloc.datasource.loadInitial();
              },
              error: data.error,
            );
          }

          return Center(child: CircularProgressIndicator());
        },
        stream: _bloc.datasource.movies,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewMoviePage()),
          );
        },
        icon: Icon(Icons.movie_creation),
        label: Text(AppLocalizations.of(context).newMovie),
      ),
    );
  }

  _buildSearchWidget(BuildContext context) {
    return PreferredSize(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        child: Padding(
          padding: const EdgeInsets.only(left:8.0,right: 8.0),
          child: TypeAheadFormField(
            key: _searchKey,
            textFieldConfiguration: TextFieldConfiguration(
              controller: _searchCtrl,
              autofocus: false,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: IconButton(icon: Icon(Icons.clear), onPressed: (){
                    _searchCtrl.clear();
                    FocusScope.of(context).requestFocus(FocusNode());
                  }) ,
                  hintText: AppLocalizations.of(context).searchLabel,
                  enabled: false
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
      ),
      preferredSize: Size(double.infinity, 70),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchField.dispose();
    super.dispose();
  }
}
