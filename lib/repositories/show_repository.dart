import 'package:ninjanga3/config/shared_preferences.dart';
import 'package:ninjanga3/infrastructure/Retriever/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/services/trackt_tv_series.dart';
import 'package:ninjanga3/models/View/featured_view.dart';
import 'package:ninjanga3/models/View/poster_view.dart';
import 'package:ninjanga3/models/View/video_view.dart';
import 'package:ninjanga3/models/db/episode_db.dart';
import 'package:ninjanga3/models/db/show_db.dart';
import 'package:ninjanga3/repositories/common.dart';
import 'package:sembast/sembast.dart';

import 'authentication_repository.dart';
import 'repository.dart';

class ShowRepository extends Repository<ShowDb> {
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

  Future<List<ShowDb>> read([Finder finder]) async {
    var data = await store.find(await db, finder: finder);
    return data.map((mov) => ShowDb.fromJson(mov.value)).toList();
  }

//
//  // database

  Future<List<PosterView>> getRelatedShows({
    String slug,
  }) async {
    final moviesTrackt =
        await tracktTvSerieClient.getRelatedShows(slug: slug, extended: false);
    final related = await Common.completeShowsImagesFromTracktList(
        moviesTrackt, tmdbClient, "related");
    List<PosterView> posters =
        related.map<PosterView>((mov) => mov.getPosterView()).toList();
    return posters.toList();
  }

  Future _fetchPopularShows(
      {int page = 0, int pageLimit = 10, extended: true}) async {
    var moviesTrackt = await tracktTvSerieClient.getPopularTvShowList(
        extended: extended, page: page, pageLimit: pageLimit);
    var movies = await Common.completeShowsImagesFromTracktList(
        moviesTrackt, tmdbClient, "popular");
    await insertAll(movies);
  }

  Future _fetchTrendingShows(
      {int page = 0, int pageLimit = 10, extended: true}) async {
    var moviesTrackt = await tracktTvSerieClient.getTrendingTvShowList(
        extended: extended, page: page, pageLimit: pageLimit);
    var movies = await Common.completeShowsImagesFromTracktList(
        moviesTrackt, tmdbClient, "trending");
    await insertAll(movies);
  }

  Future _fetchFeaturesShows(
      {int page = 0, int pageLimit = 10, extended: true}) async {
    var moviesTrackt = await tracktTvSerieClient.getTrendingTvShowList(
        extended: extended, page: page, pageLimit: pageLimit);

    var movies = await Common.completeShowsImagesFromTracktList(
        moviesTrackt, tmdbClient, "featured");
    await insertAll(movies);
  }

  Future _fetchShowList(String type) async {
    if (type.contains("Popular")) return await _fetchPopularShows();
    if (type.contains("Trending")) return await _fetchTrendingShows();
    if (type.contains("Featured")) return await _fetchFeaturesShows(page: 2);
//    if (type == "Recomended for you") return await getRecomendedMovies();
    await _fetchPopularShows(page: 3);
  }

  Future fetchHomeData() async {
    //await store.delete(await db);
    if (await needsRefresh()) {
      var futures = [
        "Featured",
        "Recomended movies for you",
        "Popular movies",
        "Trending movies",
      ].map((type) async => {type: await _fetchShowList(type)}).toList();

      await Future.wait(futures);
      await setRefresh();
    } else {
      print('no needs to fetch series');
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
    return ShowDb.fromJson(movie).getTrailerVideo();
  }

  Future<List<EpisodeDb>> getShowEpisodeDetails(
      {String slug, int seasonNumber}) async {
    var showDb = await store.record(slug).get(await db);
    ShowDb show;
    if (showDb == null) {
      show = await getShowDetails(slug: slug, number: seasonNumber);
    } else {
      show = ShowDb.fromJson(showDb);
    }
    if (show.containsEpisodesForSeason(seasonNumber)) {
      return show.episodes.toList();
    }

    var episodes = await tracktTvSerieClient.getAllEpisodesOfSeason(
        slug: slug, number: seasonNumber, extended: true);
    var episodesDb =
        await Common.completeEpisodeImagesFromTrackt(episodes, tmdbClient);
    print("heooasdfasdfasdfasdfasdfasfdasdf");
    ShowDb showClone = show.clone();
    print(showClone == show);
    showClone.addEpisodes(episodesDb);
    await update(showClone);
    return episodesDb;
  }

  Future<ShowDb> getShowDetails({String slug, int number}) async {
    var showDb = await store.record(slug).get(await db);
    ShowDb show;
    if (showDb == null) {
      var showTrackt = await tracktTvSerieClient.getShowData(slug: slug);
      var shows = await Common.completeShowsImagesFromTracktList(
          [showTrackt], tmdbClient, "details");
      show = shows.first;
      await insert(show);
    } else
      show = ShowDb.fromJson(showDb);

    if (show.seasonAmount == null) {
      ShowDb showClone = show.clone();
      showClone.seasonAmount =
          await tracktTvSerieClient.getAmountOfSeasonsForShow(slug: slug);
      update(showClone);
      return showClone;
    }
    return show;
  }
}
