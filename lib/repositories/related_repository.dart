import 'package:ninjanga3/infrastructure/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/tracktv/services/trackt_tv_movies.dart';
import 'package:ninjanga3/models/movie_view.dart';
import 'package:ninjanga3/repositories/common.dart';

class RelatedRepository {
  final TracktTvMoviesAPI client;
  final TmdbClient tmdbClient;

  RelatedRepository(this.client, this.tmdbClient);

  Future<List<MovieView>> getRelatedMovies(
      {String slug, extended = false}) async {
    final moviesTrackt =
        await client.getRelatedMovies(slug: slug, extended: extended);
    return await Common.completeMovieDataFromTracktList(
        moviesTrackt, tmdbClient);
  }
}
