import 'package:ninjanga3/config/shared_preferences.dart';
import 'package:ninjanga3/infrastructure/Retriever/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/services/trackt_tv_series.dart';
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

class ShowRepository extends Repository<MovieDb> {
  final TracktTvSeriesAPI tracktTvSerieClient;
  final TmdbClient tmdbClient;

  ShowRepository(
      {AuthenticationRepository authRepo,
      Preferences preferences,
      Future<Database> db,
      storeName,
      this.tracktTvSerieClient,
      this.tmdbClient})
      : super(authRepo, preferences, db, storeName);

  Future<List<MovieDb>> read([Finder finder]) async {
    var data = await store.find(await db, finder: finder);
    return data.map((mov) => MovieDb.fromJson(mov.value)).toList();
  }

//
//  // database

  Future<List<PosterView>> getRelatedShows({
    String slug,
  }) async {
    final moviesTrackt =
        await tracktTvSerieClient.getRelatedShows(slug: slug, extended: false);
    final related = await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient, "related");
    List<PosterView> posters =
        related.map<PosterView>((mov) => mov.getPosterView()).toList();
    return posters.toList();
  }

  Future _fetchPopularShows(
      {int page = 0, int pageLimit = 10, extended: true}) async {
    var moviesTrackt = await tracktTvSerieClient.getPopularTvShowList(
        extended: extended, page: page, pageLimit: pageLimit);
    var movies = await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient, "popular");
    await insertAll(movies);
  }

  Future _fetchTrendingShows(
      {int page = 0, int pageLimit = 10, extended: true}) async {
    var moviesTrackt = await tracktTvSerieClient.getTrendingTvShowList(
        extended: extended, page: page, pageLimit: pageLimit);
    var movies = await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient, "trending");
    await insertAll(movies);
  }

  Future _fetchFeaturesShows(
      {int page = 0, int pageLimit = 10, extended: true}) async {
    var moviesTrackt = await tracktTvSerieClient.getTrendingTvShowList(
        extended: extended, page: page, pageLimit: pageLimit);
    var movies = await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient, "featured");
    await insertAll(movies);
  }

  Future _fetchMoviesList(String type) async {
    if (await needsRefresh()) {
      if (type.contains("Popular")) return await _fetchPopularShows();
      if (type.contains("Trending")) return await _fetchTrendingShows();
      if (type.contains("Featured")) return await _fetchFeaturesShows(page: 2);
//    if (type == "Recomended for you") return await getRecomendedMovies();
      await _fetchPopularShows(page: 3);
      preferences.setLastRefresh();
    } else {
      print('no needs to fetch featured movies');
    }
  }

  Future<HomePageModel> getHomePageModel() async {
//    await _movieStore.delete(await db);
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
    var featuredViews =
        featured.map<FeaturedView>((mov) => mov.getFeaturedView()).toList();

    var movies =
        await read(Finder(filter: Filter.notEquals("origin", "featured")));

    var posterViews =
        movies.map<PosterView>((mov) => mov.getPosterView()).toList();

    return HomePageModel(movies: posterViews, featuredMovies: featuredViews);
  }

  Future<VideoView> getVideoView({String slug}) async {
    var movie = await store.record(slug).get(await db);
    return MovieDb.fromJson(movie).getTrailerVideo();
  }

  Future<MovieView> getMovieDetails(String slug) async {
    var movieTrackt = await tracktTvSerieClient.getShowData(slug: slug);
    var movie = await Common.completeMovieDataFromTrackt(
        movieTrackt, tmdbClient, "details");
    await insert(movie);
    return movie.getMovieView();
  }
}
