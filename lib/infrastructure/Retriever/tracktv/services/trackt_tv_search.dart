import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Common/search_results.dart';

import '../config_constants.dart';

class TrackTvSearchAPI {
  final http.Client client;

  TrackTvSearchAPI(this.client);

  Future<List<SearchResults>> searchQuery(String query) async {
    Uri uri = Uri.parse(
        Constants.apiUrl + "/search/movie,show?query=$query&fields=title");
    Iterable response = await client
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

    return response
        .map<SearchResults>((result) => SearchResults.fromJson(result))
        .toList();
  }
}
