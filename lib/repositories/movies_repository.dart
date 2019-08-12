import 'package:ninjanga3/infrastructure/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/tracktv/services/trackt_tv_movies.dart';
import 'package:ninjanga3/models/home_page_model.dart';
import 'package:ninjanga3/models/movie_view.dart';
import 'package:ninjanga3/repositories/common.dart';

import 'authentication_repository.dart';

class MoviesRepository {
  final TracktTvMoviesAPI tracktTvClient;
  final TmdbClient tmdbClient;
  final AuthenticationRepository authRepo;
  String _accessToken = "";

  MoviesRepository(this.tracktTvClient, this.tmdbClient, this.authRepo);


  Future<List<MovieView>> getPopularMovies(
      {int page = 0, int pageLimit = 10, extended: false}) async {
    var moviesTrackt = await tracktTvClient.getPopularMoviesList(
        extended: extended, page: page, pageLimit: pageLimit);
    return await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient);
  }

  Future<List<MovieView>> getTrendingMovies(
      {int page = 0, int pageLimit = 10, extended: false}) async {
    var moviesTrackt = await tracktTvClient.getTrendingMoviesList(
        extended: extended, page: page, pageLimit: pageLimit);
    return await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient);
  }

  Future<List<MovieView>> getRecomendedMovies(
      {int page = 0, int pageLimit = 10, extended: false}) async {
    if (_accessToken.isEmpty)
      _accessToken = await authRepo.getAccessToken();

    var moviesTrackt = await tracktTvClient.getRecomendedMovies(
        accessToken: _accessToken, page: page, pageLimit: pageLimit);
    return await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient);
  }

  Future<List<MovieView>> getMoviesList(String type) async {
    if (type == "Popular") return await getPopularMovies();
    if (type == "Trending") return await getTrendingMovies();
    if (type == "Recomended for you") return await getRecomendedMovies();

    return await getPopularMovies();
  }

  Future<HomePageModel> getHomePageModel() async {
    //TODO is only fetching popular movies 2 times
    var futures = ["Recomended for you", "Popular", "Trending", "Watching Now",]
        .map((type) async => {type: await getMoviesList(type)})
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
