import 'package:ninjanga3/infrastructure/Retriever/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/services/trackt_tv_config.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/services/trackt_tv_movies.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/services/trackt_tv_series.dart';

class RetrieverApi {
  final TracktTvMoviesAPI tracktTvMoviesAPI;
  final TracktTvSeriesAPI tracktTvSeriesAPI;
  final TracktvConfigApi tracktvConfigApi;
  final TmdbClient tmdbClient;

  RetrieverApi(this.tracktTvMoviesAPI, this.tracktTvSeriesAPI,
      this.tracktvConfigApi, this.tmdbClient);
}
