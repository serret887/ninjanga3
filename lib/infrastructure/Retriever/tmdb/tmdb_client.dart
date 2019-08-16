import 'dart:convert';

import 'package:http/http.dart' as http;

import '../tmdb/models/images_tmdb.dart';
import '../tracktv/config_constants.dart';
import '../utils/resilient_service.dart';

class TmdbClient extends ResilientService {
  final http.Client client;

  TmdbClient(this.client);

  Future<ImagesTmdb> getImagesFromMovieId(int movieId) async {
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/images?api_key=${Constants.tmdbKey}');
    var response = await getWithResilience(uri);
    if (response.statusCode != 200) {
      print(
          'retrieving images for movie status code: ${response.statusCode} - url:$uri');
      return ImagesTmdb();
    }
    //TODO when the response is not 200
    return ImagesTmdb.fromJson(json.decode(response.body));
  }

  Future<ImagesTmdb> getImagesForShow({
    int tvId,
  }) async {
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/tv/$tvId/images?api_key=${Constants.tmdbKey}');
    var response = await getWithResilience(uri);
    if (response.statusCode != 200) {
      print(
          'retrieving images for episode status code: ${response.statusCode} - url:$uri');
      return ImagesTmdb();
    }
    //TODO when the response is not 200
    return ImagesTmdb.fromJson(json.decode(response.body));
  }

  Future<ImagesTmdb> getImagesForEpisode(
      {int tvId, int seasonNumber, int episodeId}) async {
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/tv/$tvId/season/$seasonNumber/episode/$episodeId/images?api_key=${Constants.tmdbKey}');
    var response = await getWithResilience(uri);
    if (response.statusCode != 200) {
      print(
          'retrieving images for episode status code: ${response.statusCode} - url:$uri');
      return ImagesTmdb();
    }
    //TODO when the response is not 200
    return ImagesTmdb.fromJson(json.decode(response.body));
  }

  Future<ImagesTmdb> getImagesForSeason({int tvId, int seasonNumber}) async {
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/tv/$tvId/season/$seasonNumber/images?api_key=${Constants.tmdbKey}');
    var response = await getWithResilience(uri);
    if (response.statusCode != 200) {
      print(
          'retrieving images for season status code: ${response.statusCode} - url:$uri');
      return ImagesTmdb();
    }
    //TODO when the response is not 200
    return ImagesTmdb.fromJson(json.decode(response.body));
  }
}
