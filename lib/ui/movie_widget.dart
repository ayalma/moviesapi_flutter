import 'package:flutter/material.dart';
import 'package:moviesapi_flutter/datasource/model/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieWidget extends StatelessWidget {
  final Movie item;

  const MovieWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: item.images != null
                  ? CachedNetworkImage(
                      imageUrl: item.images[0],
                      placeholder: new CircularProgressIndicator(),
                      errorWidget: new Icon(Icons.error),
                    )
                  : Container(
                      child: Placeholder(),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                item.title,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            _buildGenresWidget(context, item.genres),
          ],
        ),
      ),
    );
  }

  Widget _buildGenresWidget(BuildContext context, List<String> genres) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: 72,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              label: Text(genres[index]),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
      ),
    );
  }
}
