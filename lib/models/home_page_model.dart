import 'package:ninjanga3/models/View/featured_view.dart';
import 'package:ninjanga3/models/View/poster_view.dart';

class HomePageModel {
  final Map<String, List<PosterView>> movies;
  final List<FeaturedView> featuredMovies;

  HomePageModel(this.movies, this.featuredMovies);

  List<FeaturedView> getFeaturedMovies() {
    return featuredMovies;
  }

  Iterable<MapEntry<String, List<PosterView>>> getAllMovies() {
    return movies.entries.toList();
  }
}
