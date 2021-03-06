import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moviesapi_flutter/datasource/api/movie_api.dart';
import 'package:moviesapi_flutter/datasource/model/movie.dart';
import 'package:moviesapi_flutter/main.dart';
import 'package:moviesapi_flutter/repository/movieRepository.dart';
import 'package:moviesapi_flutter/ui/movie_list_bloc.dart';

class MoviePage extends StatefulWidget {
  final MovieListBloc _bloc = getIt.get();
  final int id;

  MoviePage({Key key, this.id}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final _controller = new PageController();
  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);

  @override
  void initState() {
    // TODO: implement initState
    widget._bloc.fetchMovie(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (context, AsyncSnapshot<Movie> item) {
          if (item.hasData) {
            final movie = item.data;
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    child: SliverAppBar(
                      title: Text(movie.title),
                      flexibleSpace: buildFlexibleSpaceBar(movie),
                      expandedHeight: 270,
                    ),
                  ),
                ];
              },
              body: Builder(builder: (context) {
                return RefreshIndicator(
                  onRefresh: () {
                    return widget._bloc.fetchMovie(widget.id);
                    return Future.value(true);
                  },
                  child: CustomScrollView(
                    // The "controller" and "primary" members should be left
                    // unset, so that the NestedScrollView can control this
                    // inner scroll view.
                    // If the "controller" property is set, then this scroll
                    // view will not be associated with the NestedScrollView.
                    // The PageStorageKey should be unique to this ScrollView;
                    // it allows the list to remember its scroll position when
                    // the tab view is not on the screen.
                    key: PageStorageKey<String>("test"),
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        // This is the flip side of the SliverOverlapAbsorber above.
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(8.0),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(<Widget>[
                            Row(
                              children: <Widget>[
                                ClipRRect(
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    child: Image.network(
                                      movie.poster,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24.0)),
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(movie.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .title),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(movie.year,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            (movie.genres != null)
                                ? Container(
                                    height: 50,
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
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
                                  )
                                : Container(),
                            Text(
                              movie.writer ?? "",
                              style: Theme.of(context).textTheme.body2,
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              movie.actors ?? "",
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          } else if (item.hasError) {
            return Center(child: Text(item.error.toString()));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        stream: widget._bloc.movie,
      ),
    );
  }

  /*
  CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: Text(movie.title),
                  flexibleSpace: buildFlexibleSpaceBar(movie),
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
                              width: 48,
                              height: 48,
                              child: Image.network(
                                movie.poster,
                                fit: BoxFit.cover,
                              ),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.0)),
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
                      Text(
                        movie.writer,
                        style: Theme.of(context).textTheme.body2,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        movie.actors,
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ]),
                  ),
                ),
              ],
            ),
  * */

  FlexibleSpaceBar buildFlexibleSpaceBar(Movie movie) {
    return FlexibleSpaceBar(
        background: (movie.images != null)
            ? Stack(
                children: [
                  PageView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return Image.network(
                        movie.images[index],
                        fit: BoxFit.fill,
                      );
                    },
                    itemCount: movie.images.length,
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: new Container(
                      color: Colors.grey[800].withOpacity(0.5),
                      padding: const EdgeInsets.all(20.0),
                      child: new Center(
                        child: new DotsIndicator(
                          controller: _controller,
                          itemCount: movie.images.length,
                          onPageSelected: (int page) {
                            _controller.animateToPage(
                              page,
                              duration: _kDuration,
                              curve: _kCurve,
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Container());
  }
}

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
