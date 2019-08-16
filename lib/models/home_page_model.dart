import "package:collection/collection.dart";
import 'package:ninjanga3/models/View/featured_view.dart';
import 'package:ninjanga3/models/View/poster_view.dart';

class HomePageModel {
  List<MapEntry<String, List<PosterView>>> _movies;
  List<FeaturedView> _featuredMovies;


  HomePageModel({List<PosterView> movies, List<FeaturedView> featuredMovies}) {
    this._movies = groupBy(
        movies, (mov) => _transformOriginToUIName((mov as PosterView).origin))
        .entries.toList();
    this._featuredMovies = featuredMovies;
  }

  String _transformOriginToUIName(String origin) {
    switch (origin) {
      case "popular":
        return "Popular ";
      case "trending":
        return "Trending ";
      case "recommended":
        return "Recomended for you";
      default:
        return "Other";
    }
  }


  List<FeaturedView> getFeaturedMovies() {
    return _featuredMovies;
  }

  List<MapEntry<String, List<PosterView>>> getAllMovies() {
    return _movies;
  }
}
