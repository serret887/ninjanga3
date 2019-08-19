import 'package:ninjanga3/infrastructure/Retriever/tmdb/models/images_tmdb.dart';
import 'package:ninjanga3/infrastructure/Retriever/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/services/trackt_tv_search.dart';
import 'package:ninjanga3/models/View/poster_view.dart';

class SearchRepository {
  final TrackTvSearchAPI searchAPI;
  final TmdbClient tmdbClient;

  SearchRepository(this.searchAPI, this.tmdbClient);

  Future<List<PosterView>> search(String query) async {
    var response = await searchAPI.searchQuery(query);

    var posterViews = await response.map<Future<PosterView>>((resp) async {
      ImagesTmdb images;
      bool isMovie;
      String slug;
      if (resp.type == "movie") {
        images = await tmdbClient.getImagesFromMovieId(resp.movie.ids.tmdb);
        isMovie = true;
        slug = resp.movie.ids.slug;
      }
      if (resp.type == "show") {
        slug = resp.show.ids.slug;
        images = await tmdbClient.getImagesForShow(tvId: resp.show.ids.tmdb);
        isMovie = false;
      }
      return PosterView(
        isMovie: isMovie,
        slug: slug,
        backDropImage: images.getBestBackdrop(),
        posterImage: images.getBestPoster(),
      );
    });

    var results = await Future.wait(posterViews);
    return results.toList();
  }
}
