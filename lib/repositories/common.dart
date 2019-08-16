import 'package:ninjanga3/infrastructure/Retriever/tmdb/models/images_tmdb.dart';
import 'package:ninjanga3/infrastructure/Retriever/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Movie/movie_trackt_tv.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/TvShow/season.dart';
import 'package:ninjanga3/models/View/movie_view.dart';
import 'package:ninjanga3/models/View/seasonView.dart';

class Common {
  static MovieView convertFrom(
      MovieTrackTV trackt, ImagesTmdb tmdb, String origin) {
    return MovieView(
        backdrop: tmdb.getBestBackdrop(),
        certification: trackt.certification,
        genres: trackt.genres,
        ids: trackt.ids,
        overview: trackt.overview,
        posterImage: tmdb.getBestPoster(),
        rating: trackt.rating,
        tagline: trackt.tagline,
        title: trackt.title,
        trailer: trackt.trailer,
        year: trackt.year,
        duration: trackt.runtime,
        isMovie: true,
        origin: origin);
  }

// movie
  static Future<List<ImagesTmdb>> getImagesForMoviesFromIds(
      Iterable<int> tmdbIds, TmdbClient tmdbClient) async {
    var futures = tmdbIds.map((ids) => tmdbClient.getImagesFromMovieId(ids));
    return await Future.wait(futures);
  }

  static Future<List<MovieView>> completeMovieDataFromTracktList(
      Iterable<MovieTrackTV> moviesTrackt,
      TmdbClient tmdbClient,
      String origin) async {
    var futures = moviesTrackt
        .map((mov) => completeMovieDataFromTrackt(mov, tmdbClient, origin));
    return Future.wait(futures);
  }

  static Future<MovieView> completeMovieDataFromTrackt(
      MovieTrackTV movieTrackt, TmdbClient tmdbClient, String origin) async {
    var tmdbId = movieTrackt.ids.tmdb;
    var tmdbMovies = await tmdbClient.getImagesFromMovieId(tmdbId);
    return Common.convertFrom(movieTrackt, tmdbMovies, origin);
  }

// end movie
// show
  static Future<SeasonView> retriveShowImagesFromTrackt(
      Season seasonTracktv, TmdbClient tmdbClient, String origin) async {
    var tmdbId = seasonTracktv.ids.tmdb;
    var tmdbImages = await tmdbClient.getImagesForShow(tvId: tmdbId);
    return Common.convertFrom(seasonTracktv, tmdbImages, origin);
  }

  static Future<List<SeasonView>> completeSeasonImagesFromTracktList(
      Iterable<Season> season, TmdbClient tmdbClient, String origin) async {
    var futures = season
        .map((mov) => retriveShowImagesFromTrackt(mov, tmdbClient, origin));
    return Future.wait(futures);
  }

  static Future<SeasonView> completeSeasonImagesFromTrackt(
      Season seasonTrackt, TmdbClient tmdbClient) async {
    var tmdbMovies = await tmdbClient.getImagesForSeason(
        seasonNumber: seasonTrackt.number, tvId: seasonTrackt.ids.tmdb);
    return Common.convertFrom(seasonTrackt, tmdbMovies);
  }

  static convertFromSeasonToSeasonView(
          Season season, ImagesTmdb tmdb, String origin) =>
      SeasonView(
          backdrop: tmdb.getBestBackdrop(),
          ids: season.ids,
          posterImage: tmdb.getBestPoster(),
          isMovie: true,
          origin: origin);

  // end show
}
