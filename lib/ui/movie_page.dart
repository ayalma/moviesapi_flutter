import 'package:flutter/material.dart';
import 'package:moviesapi_flutter/datasource/api/movie_api.dart';
import 'package:moviesapi_flutter/datasource/model/movie.dart';
import 'package:moviesapi_flutter/repository/movieRepository.dart';
import 'package:moviesapi_flutter/ui/movie_list_bloc.dart';

class MoviePage extends StatefulWidget {
  final MovieListBloc bloc;
  final int id;

  const MoviePage({Key key, this.bloc, this.id}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    // TODO: implement initState
    widget.bloc.fetchMovie(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, AsyncSnapshot<Movie> item) {
        if (item.hasData) {
          final movie = item.data;
          return Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: Text(movie.title),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      movie.images[0],
                      fit: BoxFit.fill,
                    ),
                  ),
                  expandedHeight: 270,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            child: Container(
                              width:48,
                              height:48,
                              child: Image.network(
                                movie.poster,
                                fit: BoxFit.cover,
                              ),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(24.0)),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(movie.title,
                                    style: Theme.of(context).textTheme.title),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(movie.year,
                                    style:
                                        Theme.of(context).textTheme.subtitle),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Container(
                        height: 50,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Chip(
                                label: Text(
                                  movie.genres[index].toLowerCase(),
                                ),
                              ),
                            );
                          },
                          itemCount: movie.genres.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),

                      Text(movie.writer,style: Theme.of(context).textTheme.body2,),
                    ]),
                  ),
                ),
              ],
            ),
          );
        } else
          return Text(item.error.toString());
      },
      stream: widget.bloc.movie,
    );
  }
}
