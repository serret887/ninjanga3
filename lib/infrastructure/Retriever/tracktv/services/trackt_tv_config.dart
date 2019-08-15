import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config_constants.dart';
import '../models/Common/genre.dart';

enum GenreType { shows, movies }

class TracktvConfigApi {
  final http.Client client;

  TracktvConfigApi(this.client);

  /// The type in this function could be
  /// movies or shows
  Future<List<Genre>> getGenres(GenreType type) async {
    String parameter = '';
    if (type == GenreType.shows)
      parameter = 'shows';
    else
      parameter = 'movies';

    Uri uri = Uri.parse(Constants.apiUrl + 'genres/$parameter');

    var response = await client
        .get(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'trakt-api-version': Constants.apiVersionHeaderKey,
            'trakt-api-key': Constants.apiClientIdHeaderKey
          },
        )
        .then(((resp) => json.decode(resp.body)))
        .catchError((err) => print(err));
    return response.map((r) => Genre.fromJson(r));
  }
}
