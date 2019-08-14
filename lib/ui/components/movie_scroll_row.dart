import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:ninjanga3/models/movie_view.dart';
import 'package:ninjanga3/ui/components/poster_item.dart';

class MovieScrollRow extends StatelessWidget {
  final List<MovieView> movies;

  const MovieScrollRow({@required Key key, @required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            key: key,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              var movie = movies[index];
              return PosterItem(
                movieSlug: movie.ids.slug,
                posterImage: movie.posterImage,
                rating: movie.rating,
              );
            },
            padding: EdgeInsets.only(left: 14.0),
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics()));
  }
}
