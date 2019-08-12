import 'dart:convert';

import 'package:ninjanga3/infrastructure/tmdb/models/images_tmdb.dart';
import 'package:ninjanga3/infrastructure/tracktv/config_constants.dart';
import 'package:ninjanga3/infrastructure/utils/resilient_service.dart';

import 'package:http/http.dart' as http;

class TmdbClient extends ResilientService {
  final http.Client client;

  TmdbClient(this.client);

  Future<ImagesTmdb> getImagesFromMovieId(int movieId) async {
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/images?api_key=${Constants.tmdbKey}');
    var response = await getWithResilience(uri);
    //TODO when the response is not 200
    return ImagesTmdb.fromJson(json.decode(response.body));
  }
}
