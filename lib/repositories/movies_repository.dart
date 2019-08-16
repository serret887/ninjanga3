import 'package:ninjanga3/config/shared_preferences.dart';
import 'package:ninjanga3/infrastructure/Retriever/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/services/trackt_tv_movies.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/services/trackt_tv_series.dart';
import 'package:ninjanga3/models/View/movie_view.dart';
import 'package:ninjanga3/models/View/poster_view.dart';
import 'package:ninjanga3/models/db/movieDb.dart';
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

  Future insert(MovieDb movie) async =>
      await _movieStore.record(movie.ids.slug).add(await db, movie.toJson());

  Future insertAll(List<MovieDb> movies) async {
    await (await db).transaction((txn) async {
      var futures = movies.map((mov) async => await _movieStore
          .record(mov.ids.slug)
          .add(txn, mov.toJson())
          .catchError((error) => print(error)));
      await Future.wait(futures);
    });
  }

  Future<List<MovieDb>> read([Finder finder]) async {
    var data = await _movieStore.find(await db, finder: finder);
    return data.map((mov) => MovieDb.fromJson(mov.value)).toList();
  }

  // database

  Future<List<PosterView>> getRelatedMovies({
    String slug,
  }) async {
    final moviesTrackt =
        await tracktTvMovieClient.getRelatedMovies(slug: slug, extended: false);
    var related = await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient, "related");
    return related.map((mov) => mov.getPosterView());
  }

  Future _fetchPopularMovies(
      {int page = 0, int pageLimit = 10, extended: true}) async {
    if (await _needsRefresh()) {
      var moviesTrackt = await tracktTvMovieClient.getPopularMoviesList(
          extended: extended, page: page, pageLimit: pageLimit);
      var movies = await Common.completeMovieDataFromTracktList(
          moviesTrackt, tmdbClient, "popular");
      await insertAll(movies);
    }

    // return await read(Finder(
    //   filter: Filter.equals("origin", "popular"),
    //   //   sortOrders: [SortOrder('rating')]
    // ));
  }

  Future _fetchTrendingMovies(
      {int page = 0, int pageLimit = 10, extended: true}) async {
    if (await _needsRefresh()) {
      var moviesTrackt = await tracktTvMovieClient.getTrendingMoviesList(
          extended: extended, page: page, pageLimit: pageLimit);
      var movies = await Common.completeMovieDataFromTracktList(
          moviesTrackt, tmdbClient, "trending");
      insertAll(movies);
    }

    return await read(Finder(
      filter: Filter.equals("origin", "popular"),
      //   sortOrders: [SortOrder('rating')]
    ));
  }

  Future _fetchRecommendedMovies(
      {int page = 0, int pageLimit = 10, extended: false}) async {
    var _accessToken = await authRepo.getAccessToken();

    var moviesTrackt = await tracktTvMovieClient.getRecomendedMovies(
        accessToken: _accessToken, page: page, pageLimit: pageLimit);
    return await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient, "recommended");
  }

  Future _fetchFeaturesMovies(
      {int page = 0, int pageLimit = 10, extended: true}) async {
    if (await _needsRefresh()) {
      var moviesTrackt = await tracktTvMovieClient.getTrendingMoviesList(
          extended: extended, page: page, pageLimit: pageLimit);
      var movies = await Common.completeMovieDataFromTracktList(
          moviesTrackt, tmdbClient, "featured");
      insertAll(movies);
    }
  }

  Future _fetchMoviesList(String type) async {
    if (type.contains("Popular")) return await _fetchPopularMovies();
    if (type.contains("Trending")) return await _fetchTrendingMovies();
    if (type.contains("Featured")) return await _fetchFeaturesMovies(page: 2);
//    if (type == "Recomended for you") return await getRecomendedMovies();
    await _fetchPopularMovies(page: 3);
  }

  Future<HomePageModel> getHomePageModel() async {
    var futures = [
      "Featured",
      "Recomended movies for you",
      "Popular movies",
      "Trending movies",
    ].map((type) async => {type: await _fetchMoviesList(type)}).toList();

    await Future.wait(futures);

    var featured = await read(Finder(
      filter: Filter.equals("origin", "featured"),
    ));
    var featuredViews = featured.map((mov) => mov.getFeaturedView());
    var movies =
        await read(Finder(filter: Filter.notEquals("origin", "featured")));
    var posterViews = movies.map((mov) => mov.getPosterView());

    return HomePageModel(posterViews, featuredViews);
  }

  Future<MovieView> getMovieDetails(String slug) async {
    var movieTrackt = await tracktTvMovieClient.getMovieData(slug: slug);
    var movie = await Common.completeMovieDataFromTrackt(
        movieTrackt, tmdbClient, "details");
    await insert(movie);
    return movie.getMovieView();
  }
}
