import 'package:ninjanga3/config/shared_preferences.dart';
import 'package:ninjanga3/infrastructure/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/tracktv/services/trackt_tv_movies.dart';
import 'package:ninjanga3/infrastructure/tracktv/services/trackt_tv_series.dart';
import 'package:ninjanga3/models/View/movie_view.dart';
import 'package:ninjanga3/models/home_page_model.dart';
import 'package:ninjanga3/repositories/common.dart';
import 'package:sembast/sembast.dart';

import 'authentication_repository.dart';

class MoviesRepository {
  final TracktTvMoviesAPI tracktTvMovieClient;
  final TracktTvSeriesAPI tracktTvSerieClient;
  final TmdbClient tmdbClient;
  final AuthenticationRepository authRepo;
  final Preferences preferences;
  final Future<Database> db;

  static const String MOVIE_STORE_NAME = 'movies';
  final _movieStore = stringMapStoreFactory.store(MOVIE_STORE_NAME);

  MoviesRepository(this.tracktTvMovieClient, this.tracktTvSerieClient,
      this.tmdbClient, this.authRepo, this.preferences, this.db);

  // database

  Future<bool> _needsRefresh() async {
    var lastRefresh = await preferences.getLastRefresh();
    return DateTime.now().difference(lastRefresh) > Duration(days: 1);
  }

  Future insert(MovieView movie) async {
    await _movieStore.add(await db, movie.ToMap());
  }

  Future insertAll(List<MovieView> movies) async {
    List<Map<String, dynamic>> moviesMap = movies.map((mov) => mov.ToMap());
    await _movieStore.addAll(await db, moviesMap);
  }

  Future<List<MovieView>> read(Finder finder) async {
    var data = await _movieStore.find(await db, finder: finder);
    return data.map((mov) => MovieView.fromMap(mov.value)).toList();
  }

  // database

  Future<List<MovieView>> getRelatedMovies(
      {String slug, extended = false}) async {
    if (await _needsRefresh()) {
      final moviesTrackt = await tracktTvMovieClient.getRelatedMovies(
          slug: slug, extended: extended);
      var movies = await Common.completeMovieDataFromTracktList(
          moviesTrackt, tmdbClient);
      await insertAll(movies);
      return movies;
    }
    return read(null);
  }

  Future<List<MovieView>> getPopularMovies(
      {int page = 0, int pageLimit = 10, extended: true}) async {
    var moviesTrackt = await tracktTvMovieClient.getPopularMoviesList(
        extended: extended, page: page, pageLimit: pageLimit);
    return await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient);
  }

  Future<List<MovieView>> getTrendingMovies(
      {int page = 0, int pageLimit = 10, extended: true}) async {
    var moviesTrackt = await tracktTvMovieClient.getTrendingMoviesList(
        extended: extended, page: page, pageLimit: pageLimit);
    return await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient);
  }

  Future<List<MovieView>> getRecommendedMovies(
      {int page = 0, int pageLimit = 10, extended: false}) async {
    var _accessToken = await authRepo.getAccessToken();

    var moviesTrackt = await tracktTvMovieClient.getRecomendedMovies(
        accessToken: _accessToken, page: page, pageLimit: pageLimit);
    return await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient);
  }
//
//  Future<List<MovieView>> getRelatedSeries(
//      {String slug, extended = false}) async {
//    final moviesTrackt = await tracktTvSerieClient.getRelatedShows(
//        slug: slug, extended: extended);
//    return await Common.completeSerieDataFromTracktList(
//        moviesTrackt, tmdbClient);
//  }
//
//  Future<List<Show>> getPopularShows(
//      {int page = 0, int pageLimit = 10, extended: true}) async {
//    var moviesTrackt = await tracktTvSerieClient.getPopularTvShowList(
//        extended: extended, page: page, pageLimit: pageLimit);
//    return await Common.completeSerieDataFromTracktList(
//        moviesTrackt, tmdbClient);
//  }
//
//  Future<List<MovieView>> getTrendingSeries(
//      {int page = 0, int pageLimit = 10, extended: true}) async {
//    var moviesTrackt = await tracktTvSerieClient.getTrendingTvShowList(
//        extended: extended, page: page, pageLimit: pageLimit);
//    return await Common.completeSerieDataFromTracktList(
//        moviesTrackt, tmdbClient);
//  }
//
//  Future<List<MovieView>> getRecommendedSeries(
//      {int page = 0, int pageLimit = 10, extended: false}) async {
//    var _accessToken = await authRepo.getAccessToken();
//
//    var moviesTrackt = await tracktTvSerieClient.getRecommendedShows(
//        accessToken: _accessToken, page: page, pageLimit: pageLimit);
//    return await Common.completeMovieDataFromTracktList(
//        moviesTrackt, tmdbClient);
//  }

  Future<List<MovieView>> getMoviesList(String type) async {
    if (type.contains("Popular")) return await getPopularMovies();
    if (type == "Trending") return await getTrendingMovies();
    // if (type == "Recomended for you") return await getRecomendedMovies();

    return await getPopularMovies();
  }
//
//  Future<List<MovieView>> getSeriesList(String type) async {
//    if (type.contains("Popular")) return await getPopularShows();
//    if (type.contains("Trending")) return await getTrendingSeries();
//    // if (type == "Recomended for you") return await getRecomendedMovies();
//
//    return await getPopularShows();
//  }

  Future<HomePageModel> getHomePageModel() async {
    var futures = [
      "Recomended movies for you",
      "Popular movies",
      "Trending movies",
    ].map((type) async => {type: await getMoviesList(type)}).toList();
//    var futures2 = [
//      "Recomended shows for you",
//      "Popular shows",
//      "Trending shows",
//    ].map((type) async => {type: await getSeriesList(type)}).toList();
//    var watchingNow = Future.wait(
//            [getMoviesList("Watching now"), getSeriesList("Watching now")])
//        .then((val) => {"watching now": val.expand((mov) => mov).toList()})
//        .catchError((error) => print("Error retrieving watch now - $error"));
//
//    futures
//      ..addAll(futures2)
//      ..add(watchingNow);
    var movies = await Future.wait(futures);
    var model = Map.fromEntries(movies.expand((mov) => mov.entries));

    return HomePageModel(model);
  }

  Future<MovieView> getMovieDetails(String slug) async {
    var movieTrackt = await tracktTvMovieClient.getMovieData(slug: slug);
    return await Common.completeMovieDataFromTrackt(movieTrackt, tmdbClient);
  }
}
