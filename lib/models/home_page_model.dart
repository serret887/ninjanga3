import "package:collection/collection.dart";
import 'package:ninjanga3/models/View/featured_view.dart';
import 'package:ninjanga3/models/View/poster_view.dart';

class HomePageModel {
  List<MapEntry<String, List<PosterView>>> _posters;
  List<FeaturedView> _featured;

  addFeaturedViews(List<FeaturedView> view) => _featured.addAll(view);
  addPosterViews(List<MapEntry<String, List<PosterView>>> view) =>
      _posters.addAll(view);

  HomePageModel({List<PosterView> movies, List<FeaturedView> featuredMovies}) {
    this._posters =
        groupBy(movies, (mov) => _transformOriginToUIName(mov as PosterView))
            .entries
            .toList();
    this._featured = featuredMovies;
  }

  String tileTitle(String tileName, bool isMovie) =>
      '$tileName ${(isMovie == true) ? "movies" : "series"}';

  String _transformOriginToUIName(PosterView poster) {
    switch (poster.origin) {
      case "popular":
        return tileTitle("Popular", poster.isMovie);
      case "trending":
        return tileTitle("Trending", poster.isMovie);
      case "recommended":
        return "Recomended for you";
      default:
        return "Other that you have check before";
    }
  }

  List<FeaturedView> getFeatured() {
    return _featured;
  }

  List<MapEntry<String, List<PosterView>>> getAllPostersByOrigin() {
    return _posters;
  }
}
