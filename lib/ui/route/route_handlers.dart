import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ninjanga3/ui/home2/home.dart';
import 'package:ninjanga3/ui/movie_page/movie_details_page.dart';

var rootHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params,
      [dynamic object]) {
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
var detailRouteHandler = Handler(
handlerFunc: (

BuildContext context, Map
<
String, List<String>> params,) {
return MovieDetailsPage(movieSlug: 'hell',);
);
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
