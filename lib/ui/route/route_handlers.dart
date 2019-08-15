import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ninjanga3/ui/home/home.dart';
import 'package:ninjanga3/ui/movie_page/movie_details.dart';
import 'package:ninjanga3/ui/tv_details/tv_show_details.dart';

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
  if (Routes.getDetailRouterIsMovie(params) == true) {
    return MovieDetails(
      slug: Routes.getDetailRouterSlug(params),
    );
  }
  else {
    return TvShowDetails(slug: Routes.getDetailRouterSlug(params));
  }
});

var trailerRouteHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params,
      [dynamic object]) {
    return Container(
      child: Center(
        child: Text("trailer of movie"),
      ),
    ); // Video(title: object['title']);
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
    ;
  },
);
