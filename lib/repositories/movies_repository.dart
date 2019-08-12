import 'package:ninjanga3/infrastructure/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/tracktv/services/trackt_tv_movies.dart';
import 'package:ninjanga3/models/home_page_model.dart';
import 'package:ninjanga3/models/movie_view.dart';
import 'package:ninjanga3/repositories/common.dart';

class MoviesRepository {
  final TracktTvMoviesAPI tracktTvClient;
  final TmdbClient tmdbClient;

  MoviesRepository(this.tracktTvClient, this.tmdbClient);

  Future<List<MovieView>> getPopularMovies(
      {int page = 0, int pageLimit = 10, extended: false}) async {
    var moviesTrackt = await tracktTvClient.getPopularMoviesList(
        extended: extended, page: page, pageLimit: pageLimit);
    return await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient);
  }

  Future<HomePageModel> getHomePageModel() async {
    //TODO is only fetching popular movies 2 times
    var futures = Iterable.generate(2)
        .map((i) async => {i.toString(): await getPopularMovies()})
        .toList();

    var movies = await Future.wait(futures);
    var a = Map.fromEntries(movies.expand((mov) => mov.entries));
    return HomePageModel(a);
  }

  Future<MovieView> getMovieDetails(String slug) async {
    var movieTrackt = await tracktTvClient.getMovieData(slug: slug);
    return await Common.completeMovieDataFromTrackt(movieTrackt, tmdbClient);
  }
}
