import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ninjanga3/ui/home/home.dart';
import 'package:ninjanga3/ui/movie_page/movie_details.dart';
import 'package:ninjanga3/ui/tv_details/tv_show_details.dart';
import 'package:ninjanga3/ui/video/video.dart';

import 'routes.dart';

var rootHandler = Handler(
  handlerFunc: (
    BuildContext context,
    Map<String, List<String>> params,
  ) {
    return Home();
  },
);
var summaryRouteHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params,
      [dynamic object]) {
    return Container(
      child: Center(
        child: Text("summary of movie"),
      ),
    ); //Summary();;
  },
);
var detailRouteHandler = Handler(handlerFunc: (
  BuildContext context,
  Map<String, List<String>> params,
) {
  print(params);
  if (Routes.getRouterIsMovie(params) == true) {
    return MovieDetails(
      slug: Routes.getRouterSlug(params),
    );
  } else {
    return TvShowDetails(slug: Routes.getRouterSlug(params));
  }
});

var trailerRouteHandler = Handler(
  handlerFunc: (BuildContext context,
      Map<String, List<String>> params,) {

    return Video(
        slug: Routes.getRouterSlug(params),
        isMovie: Routes.getRouterIsMovie(params));
  },
);
var filterRouteHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params,
      [dynamic object]) {
    return Container(
      child: Center(
        child: Text("Retrieve all movie or series depending of the filter"),
      ),
    );
  },
);
