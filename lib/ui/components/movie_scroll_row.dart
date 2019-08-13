import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:ninjanga3/models/movie_view.dart';

import '../../service_locator.dart';
import '../route/routes.dart';

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
              return Padding(
                  padding: EdgeInsets.only(right: 6.0),
                  child: GestureDetector(
                      child: CachedNetworkImage(
                          placeholder: (context, url) {
                            return AspectRatio(
                                aspectRatio: .68,
                                child: Image.asset(
                                    "assets/icons/placeholder.png",
                                    fit: BoxFit.cover));
                          },
                          imageUrl: movie.posterImage,
                          fit: BoxFit.cover),
                      onTap: () {
                        sl.get<Router>().navigateTo(context,
                          Routes.detail,
                          transition: TransitionType.nativeModal,
                          transitionDuration: const Duration(milliseconds: 200),

                        );
//                        Navigator.pushNamed(
//                            context, MovieDetailsPageArguments.routeName,
//                            arguments: MovieDetailsPageArguments(movie));
                      }));
            },
            padding: EdgeInsets.only(left: 14.0),
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics()));
  }
}

class _ScrollItemView extends StatelessWidget {
  final MovieView movie;

  const _ScrollItemView({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CachedNetworkImage(
                  placeholder: (context, url) {
                    return AspectRatio(
                        aspectRatio: .68,
                        child: Image.asset("assets/icons/placeholder.png",
                            fit: BoxFit.cover));
                  },
                  imageUrl: movie.posterImage,
                  fit: BoxFit.cover),
              SizedBox(height: 14),
              Text(movie.title,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14, color: Colors.white))
            ]));
  }
}
