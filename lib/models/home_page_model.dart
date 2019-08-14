import 'package:ninjanga3/models/movie_view.dart';

class HomePageModel {
  final Map<String, List<MovieView>> movies;

  HomePageModel(this.movies,);

  List<MovieView> getFeaturedMovies() {
    return movies.values.expand((i) => i).take(10).toList();
  }

  Iterable<MapEntry<String, List<MovieView>>> getAllMovies() {
    return movies.entries.toList();
  }
}
