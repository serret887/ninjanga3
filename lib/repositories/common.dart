import 'package:ninjanga3/infrastructure/Retriever/tmdb/models/images_tmdb.dart';
import 'package:ninjanga3/infrastructure/Retriever/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Movie/movie_trackt_tv.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/TvShow/season.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/TvShow/show.dart';
import 'package:ninjanga3/models/db/episode_db.dart';
import 'package:ninjanga3/models/db/movieDb.dart';
import 'package:ninjanga3/models/db/season_db.dart';
import 'package:ninjanga3/models/db/show_db.dart';

class Common {
  static MovieDb convertFrom(
      MovieTrackTV trackt, ImagesTmdb tmdb, String origin) {
    return MovieDb(
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
        origin: origin);
  }

// movie
  static Future<List<ImagesTmdb>> getImagesForMoviesFromIds(
      Iterable<int> tmdbIds, TmdbClient tmdbClient) async {
    var futures = tmdbIds.map((ids) => tmdbClient.getImagesFromMovieId(ids));
    return await Future.wait(futures);
  }

  static Future<List<MovieDb>> completeMovieDataFromTracktList(
      Iterable<MovieTrackTV> moviesTrackt,
      TmdbClient tmdbClient,
      String origin) async {
    var futures = moviesTrackt
        .map((mov) => completeMovieDataFromTrackt(mov, tmdbClient, origin));
    return Future.wait(futures);
  }

  static Future<MovieDb> completeMovieDataFromTrackt(
      MovieTrackTV movieTrackt, TmdbClient tmdbClient, String origin) async {
    var tmdbId = movieTrackt.ids.tmdb;
    var tmdbMovies = await tmdbClient.getImagesFromMovieId(tmdbId);
    return Common.convertFrom(movieTrackt, tmdbMovies, origin);
  }

// end movie
// show
  static Future<ShowDb> retriveShowImagesFromTrackt(Show seasonTracktv,
      TmdbClient tmdbClient, String origin) async {
    var tmdbId = seasonTracktv.ids.tmdb;
    var tmdbImages = await tmdbClient.getImagesForShow(tvId: tmdbId);
    return Common.convertFromShow(seasonTracktv, tmdbImages, origin);
  }

  static Future<List<ShowDb>> completeShowsImagesFromTracktList(
      Iterable<Show> season, TmdbClient tmdbClient, String origin) async {
    var futures = season
        .map((mov) => retriveShowImagesFromTrackt(mov, tmdbClient, origin));
    return Future.wait(futures);
  }

  static Future<SeasonDb> completeSeasonImagesFromTrackt(Season seasonTrackt,
      TmdbClient tmdbClient) async {
    var tmdbImagesSeason = await tmdbClient.getImagesForSeason(
        seasonNumber: seasonTrackt.number, tvId: seasonTrackt.ids.tmdb);

    var episodeDbfutures = seasonTrackt.episodes.map((episode) async {
      var images = await tmdbClient.getImagesForEpisode();
      return EpisodeDb(
        season: episode.season,
        number: episode.number,
        title: episode.title,
        ids: episode.ids,
        numberAbs: episode.numberAbs,
        overview: episode.overview,
        rating: episode.rating,
        votes: episode.votes,
        commentCount: episode.commentCount,
        firstAired: episode.firstAired,
        updatedAt: episode.updatedAt,
        availableTranslations: episode.availableTranslations,
        runtime: episode.runtime,
        posterImage: images.getBestPoster(),
        backdrop: images.getBestBackdrop(),
      );
    }).toList();

    var episodes = await Future.wait(episodeDbfutures);

    return SeasonDb(
        backdrop: tmdbImagesSeason.getBestBackdrop(),
        episodes: episodes.toSet(),
        ids: seasonTrackt.ids,
        number: seasonTrackt.number,
        posterImage: tmdbImagesSeason.getBestPoster());
  }

  static ShowDb convertFromShow(Show show, ImagesTmdb tmdb, String origin) =>
      ShowDb(
          backdrop: tmdb.getBestBackdrop(),
          ids: show.ids,
          posterImage: tmdb.getBestPoster(),
          trailer: show.trailer,
          certification: show.certification,
          genres: show.genres,
          overview: show.overview,
          rating: show.rating,
          title: show.title,
          year: show.year,
          duration: show.runtime,
          airedEpisodes: show.airedEpisodes,
          airs: show.airs,
          availableTranslations: show.availableTranslations,
          language: show.language,
          network: show.network,
          runtime: show.runtime,
          status: show.status,
          origin: origin);

//   end show
}
