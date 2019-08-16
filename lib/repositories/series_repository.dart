import 'package:ninjanga3/config/shared_preferences.dart';
import 'package:ninjanga3/infrastructure/Retriever/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/services/trackt_tv_movies.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/services/trackt_tv_series.dart';
import 'package:ninjanga3/models/View/seasonView.dart';
import 'package:ninjanga3/models/home_page_model.dart';
import 'package:ninjanga3/repositories/common.dart';
import 'package:sembast/sembast.dart';

import 'authentication_repository.dart';

class SeriesRepository {
  final TracktTvMoviesAPI tracktTvMovieClient;
  final TracktTvSeriesAPI tracktTvSerieClient;
  final TmdbClient tmdbClient;
  final AuthenticationRepository authRepo;
  final Preferences preferences;
  final Future<Database> db;

  static const String SERIES_STORE_NAME = 'series';
  final _store = stringMapStoreFactory.store(SERIES_STORE_NAME);

  SeriesRepository(this.tracktTvMovieClient, this.tracktTvSerieClient,
      this.tmdbClient, this.authRepo, this.preferences, this.db);

  // database

  Future<bool> _needsRefresh() async {
    var lastRefresh = await preferences.getLastRefresh();
    return DateTime.now().difference(lastRefresh) > Duration(days: 1);
  }

  Future insert(SeasonView movie) async =>
      await _store.record(movie.ids.slug).add(await db, movie.toJson());

  Future insertAll(List<SeasonView> movies) async {
    await (await db).transaction((txn) async {
      var futures = movies.map((mov) async => await _store
          .record(mov.ids.slug)
          .add(txn, mov.toJson())
          .catchError((error) => print(error)));
      await Future.wait(futures);
    });
  }

  Future<List<SeasonView>> read([Finder finder]) async {
    var data = await _store.find(await db, finder: finder);
    return data.map((mov) => SeasonView.fromJson(mov.value)).toList();
  }

  // database

  Future<List<SeasonView>> getRelatedSeries(
      {String slug, extended = false}) async {
    final shows = await tracktTvSerieClient.getRelatedShows(
        slug: slug, extended: extended);
    return await Common.completeSerieDataFromTracktList(
        moviesTrackt, tmdbClient);
  }

  Future<List<Show>> getPopularShows(
      {int page = 0, int pageLimit = 10, extended: true}) async {
    var moviesTrackt = await tracktTvSerieClient.getPopularTvShowList(
        extended: extended, page: page, pageLimit: pageLimit);
    return await Common.completeSerieDataFromTracktList(
        moviesTrackt, tmdbClient);
  }

  Future<List<SeasonView>> getTrendingSeries(
      {int page = 0, int pageLimit = 10, extended: true}) async {
    var moviesTrackt = await tracktTvSerieClient.getTrendingTvShowList(
        extended: extended, page: page, pageLimit: pageLimit);
    return await Common.completeSerieDataFromTracktList(
        moviesTrackt, tmdbClient);
  }

  Future<List<SeasonView>> getRecommendedSeries(
      {int page = 0, int pageLimit = 10, extended: false}) async {
    var _accessToken = await authRepo.getAccessToken();

    var moviesTrackt = await tracktTvSerieClient.getRecommendedShows(
        accessToken: _accessToken, page: page, pageLimit: pageLimit);
    return await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient);
  }

  Future<HomePageModel> getHomePageModel() async {
    if (await _needsRefresh()) {
      var futures = [
        "Recomended shows for you",
        "Popular shows",
        "Trending shows",
      ].map((type) async => {type: await getSeriesList(type)}).toList();
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
//await preferences.setLastRefresh();
      return HomePageModel(model);
    }

    Future<SeasonView> getSeriesDetails(String slug) async {
      var movieTrackt = await tracktTvMovieClient.getMovieData(slug: slug);
      return await Common.completeMovieDataFromTrackt(
          movieTrackt, tmdbClient, "details");
    }
  }
}
