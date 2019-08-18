import 'dart:convert';

import 'package:flutter/material.dart';
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
      {@required int tvId,
      @required int seasonNumber,
      @required int episodeId}) async {
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

  Future<ImagesTmdb> getImagesForSeason(
      {@required int tvId, @required int seasonNumber}) async {
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

main() async {
  var a = TmdbClient(http.Client());

  // var resp = await a.getRelatedMovies(
  //   slug: 'tron-legacy-2010',
  //   extended: true,
  // );
  var resp =
      await a.getImagesForEpisode(tvId: 1048601, episodeId: 1, seasonNumber: 1);
  print(resp);
//  resp.forEach((f) => print(f.toJson()));
}
