import 'package:ninjanga3/infrastructure/Retriever/tmdb/models/images_tmdb.dart';
import 'package:ninjanga3/infrastructure/Retriever/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Movie/movie_trackt_tv.dart';
import 'package:ninjanga3/models/View/movie_view.dart';

class Common {
  static MovieView convertFrom(MovieTrackTV trackt, ImagesTmdb tmdb,
      String origin) {
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

  static Future<List<ImagesTmdb>> getImagesForMoviesFromIds(
      Iterable<int> tmdbIds, TmdbClient tmdbClient) async {
    var futures = tmdbIds.map((ids) => tmdbClient.getImagesFromMovieId(ids));
    return await Future.wait(futures);
  }

  static Future<List<MovieView>> completeMovieDataFromTracktList(
      Iterable<MovieTrackTV> moviesTrackt, TmdbClient tmdbClient,
      String origin) async {
    var futures =
    moviesTrackt.map((mov) =>
        completeMovieDataFromTrackt(mov, tmdbClient, origin));
    return Future.wait(futures);
  }

  static Future<MovieView> completeMovieDataFromTrackt(MovieTrackTV movieTrackt,
      TmdbClient tmdbClient, String origin) async {
    var tmdbId = movieTrackt.ids.tmdb;
    var tmdbMovies = await tmdbClient.getImagesFromMovieId(tmdbId);
    return Common.convertFrom(movieTrackt, tmdbMovies, origin);
  }

//  static Future<MovieView> completeSerieDataFromTrackt(
//      MovieTrackTV movieTrackt, TmdbClient tmdbClient) async {
//    var tmdbId = movieTrackt.ids.tmdb;
//    var tmdbMovies = await tmdbClient.getImagesForShow(tvId: tmdbId);
//    return Common.convertFrom(movieTrackt, tmdbMovies, origin);
//  }
//
//  static Future<List<MovieView>> completeSerieDataFromTracktList(
//      Iterable<MovieTrackTV> moviesTrackt, TmdbClient tmdbClient) async {
//    var futures =
//        moviesTrackt.map((mov) => completeSerieDataFromTrackt(mov, tmdbClient));
//    return Future.wait(futures);
//  }
//
//  static Future<MovieView> completeSeasonDataFromTrackt(
//      SeasonTracktv seasonTrackt, TmdbClient tmdbClient) async {
//    var tmdbMovies = await tmdbClient.getImagesForSeason(
//        seasonNumber: seasonTrackt.number, tvId: seasonTrackt.ids.tmdb);
//    return MovieView();
//    //   return Common.convertFrom(seasonTrackt, tmdbMovies);
//  }
}
