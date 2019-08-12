import 'package:ninjanga3/infrastructure/tmdb/models/images_tmdb.dart';
import 'package:ninjanga3/infrastructure/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/tracktv/models/movie_trackt_tv.dart';
import 'package:ninjanga3/models/movie_view.dart';

class Common {
  static MovieView convertFrom(MovieTrackTV trackt, ImagesTmdb tmdb) {
    return MovieView(
        backdrop: tmdb.getBestBackdrop(),
        certification: trackt.certification,
        genres: trackt.genres,
        ids: trackt.ids,
        overview: trackt.overview,
        posterImage: tmdb.getBestPoster(),
        rating: trackt.rating,
        released: trackt.released,
        tagline: trackt.tagline,
        title: trackt.title,
        trailer: trackt.trailer,
        year: trackt.year,
        duration: trackt.runtime);
  }

  static Future<List<ImagesTmdb>> getImagesFromIds(
      Iterable<int> tmdbIds, TmdbClient tmdbClient) async {
    var futures = tmdbIds.map((ids) => tmdbClient.getImagesFromMovieId(ids));
    return await Future.wait(futures);
  }

  static Future<List<MovieView>> completeMovieDataFromTracktList(
      Iterable<MovieTrackTV> moviesTrackt, TmdbClient tmdbClient) async {
    var futures =
        moviesTrackt.map((mov) => completeMovieDataFromTrackt(mov, tmdbClient));
    return Future.wait(futures);
  }

  static Future<MovieView> completeMovieDataFromTrackt(
      MovieTrackTV movieTrackt, TmdbClient tmdbClient) async {
    var tmdbId = movieTrackt.ids.tmdb;
    var tmdbMovies = await tmdbClient.getImagesFromMovieId(tmdbId);
    return Common.convertFrom(movieTrackt, tmdbMovies);
  }
}
