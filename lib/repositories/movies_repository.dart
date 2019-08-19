import 'package:ninjanga3/config/shared_preferences.dart';
import 'package:ninjanga3/infrastructure/Retriever/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/services/trackt_tv_movies.dart';
import 'package:ninjanga3/models/View/featured_view.dart';
import 'package:ninjanga3/models/View/movie_view.dart';
import 'package:ninjanga3/models/View/poster_view.dart';
import 'package:ninjanga3/models/View/video_view.dart';
import 'package:ninjanga3/models/db/movieDb.dart';
import 'package:ninjanga3/models/home_page_model.dart';
import 'package:ninjanga3/repositories/common.dart';
import 'package:sembast/sembast.dart';

import 'authentication_repository.dart';
import 'repository.dart';

class MoviesRepository extends Repository<MovieDb> {
  final TracktTvMoviesAPI tracktTvMovieClient;
  final TmdbClient tmdbClient;

  MoviesRepository(
      {AuthenticationRepository authRepo,
      Preferences preferences,
      Future<Database> db,
      storeName,
      this.tracktTvMovieClient,
      this.tmdbClient})
      : super(authRepo, preferences, db, storeName);

  Future<List<MovieDb>> read([Finder finder]) async {
    var data = await store.find(await db, finder: finder);
    return data.map((mov) => MovieDb.fromJson(mov.value)).toList();
  }

//
//  // database

  Future<List<PosterView>> getRelatedMovies({
    String slug,
  }) async {
    final moviesTrackt =
        await tracktTvMovieClient.getRelatedMovies(slug: slug, extended: false);
    final related = await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient, "related");
    List<PosterView> posters =
        related.map<PosterView>((mov) => mov.getPosterView()).toList();
    return posters.toList();
  }

  Future _fetchPopularMovies(
      {int page = 0, int pageLimit = 10, extended: true}) async {
    var moviesTrackt = await tracktTvMovieClient.getPopularMoviesList(
        extended: extended, page: page, pageLimit: pageLimit);
    var movies = await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient, "popular");
    await insertAll(movies);
  }

  Future _fetchTrendingMovies(
      {int page = 0, int pageLimit = 10, extended: true}) async {
    var moviesTrackt = await tracktTvMovieClient.getTrendingMoviesList(
        extended: extended, page: page, pageLimit: pageLimit);
    var movies = await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient, "trending");
    await insertAll(movies);
  }

//  Future _fetchRecommendedMovies(
//      {int page = 0, int pageLimit = 10, extended: false}) async {
//    var _accessToken = await authRepo.getAccessToken();
//
//    var moviesTrackt = await tracktTvMovieClient.getRecomendedMovies(
//        accessToken: _accessToken, page: page, pageLimit: pageLimit);
//    return await Common.completeMovieDataFromTracktList(
//        moviesTrackt, tmdbClient, "recommended");
//  }

  Future _fetchFeaturesMovies(
      {int page = 0, int pageLimit = 10, extended: true}) async {
    var moviesTrackt = await tracktTvMovieClient.getTrendingMoviesList(
        extended: extended, page: page, pageLimit: pageLimit);
    var movies = await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient, "featured");
    await insertAll(movies);
  }

  Future _fetchMoviesList(String type) async {
    if (type.contains("Popular")) return await _fetchPopularMovies();
    if (type.contains("Trending")) return await _fetchTrendingMovies();
    if (type.contains("Featured")) return await _fetchFeaturesMovies(page: 2);
//    if (type == "Recomended for you") return await getRecomendedMovies();
    await _fetchPopularMovies(page: 3);
  }

  Future<HomePageModel> fetchHomeData() async {
    if (await needsRefresh()) {
      var futures = [
        "Featured",
        "Recomended movies for you",
        "Popular movies",
        "Trending movies",
      ].map((type) async => {type: await _fetchMoviesList(type)}).toList();

      await Future.wait(futures);
      await setRefresh();
    }
  }

  Future<List<PosterView>> getAllPosters() async {
    var movies =
        await read(Finder(filter: Filter.notEquals("origin", "featured")));

    return movies.map<PosterView>((mov) => mov.getPosterView()).toList();
  }

  Future<List<FeaturedView>> getFeaturedViews() async {
    var featured = await read(Finder(
      filter: Filter.equals("origin", "featured"),
    ));
    return featured.map<FeaturedView>((mov) => mov.getFeaturedView()).toList();
  }

  Future<VideoView> getTrailerVideoView({String slug}) async {
    var movie = await store.record(slug).get(await db);
    return MovieDb.fromJson(movie).getTrailerVideo();
  }

  Future<MovieView> getMovieDetails(String slug) async {
    var movieTrackt = await tracktTvMovieClient.getMovieData(slug: slug);
    var movie = await Common.completeMovieDataFromTrackt(
        movieTrackt, tmdbClient, "details");
    await insert(movie);
    return movie.getMovieView();
  }
}
