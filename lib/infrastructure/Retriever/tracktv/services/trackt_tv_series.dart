import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config_constants.dart';
import '../models/Common/trending.dart';
import '../models/TvShow/episode.dart';
import '../models/TvShow/season.dart';
import '../models/TvShow/show.dart';

class TracktTvSeriesAPI {
  final http.Client client;

  TracktTvSeriesAPI(this.client);

  Future<List<Show>> getPopularTvShowList(
      {int page = 0, int pageLimit = 10, bool extended = false}) async {
    final parameter = (extended == true)
        ? 'shows/popular?extended=full&page=$page&limit=$pageLimit'
        : 'shows/popular?page=$page&limit=$pageLimit';

    Uri uri = Uri.parse(Constants.apiUrl + '$parameter');
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
    //TODO save the state of the pagination
    return response.map((model) => Show.fromJson(model)).toList();
  }

  /// type can be changed for
  /// played, watched, popular, trending, boxOffice
  Future<List<Show>> getTrendingTvShowList(
      {int page = 0, int pageLimit = 10, bool extended = false}) async {
    final parameter = (extended == true)
        ? 'shows/trending?extended=full&page=$page&limit=$pageLimit'
        : 'shows/trending?page=$page&limit=$pageLimit';

    Uri uri = Uri.parse(Constants.apiUrl + '$parameter');
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
    //TODO save the state of the pagination

    var c = response
        .map((model) => Trending.fromJson(model)).toList()
    ;
    var a = response
        .map((model) => Trending.fromJson(model))
        .map<Show>((mov) => mov.show)
        .toList();
    return response
        .map((model) => Trending.fromJson(model))
        .map<Show>((mov) => mov.show)
        .toList();
  }

  Future<Show> getShowData({slug, extended = true}) async {
    final parameter = (extended == true) ? '$slug?extended=full' : '$slug';

    Uri uri = Uri.parse(Constants.apiUrl + 'shows/$parameter');

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
    return Show.fromJson(response);
  }

  Future<List<Show>> getRecommendedShows(
      {String accessToken, page = 0, pageLimit = 10}) async {
    Uri uri =
        Uri.parse(Constants.apiUrl + 'recommendations/shows?limit=$pageLimit');

    var response = await client
        .get(
          uri,
          headers: {
            'Authorization': accessToken,
            'Content-Type': 'application/json',
            'trakt-api-version': Constants.apiVersionHeaderKey,
            'trakt-api-key': Constants.apiClientIdHeaderKey
          },
        )
        .then((resp) => resp)
        .catchError((err) => print(err));
    //TODO save the state of the pagination
    if (response.statusCode != 200) {
      throw Exception(
          "Can't fetch recomended movies ${response.statusCode}  ${response.body}");
    }
    var resp = json.decode(response.body);
    return resp.map((model) => Show.fromJson(model)).toList();
  }

  Future<List<Show>> getRelatedShows({String slug, extended = false}) async {
    final parameter =
        (extended == true) ? '$slug/related?extended=full' : '$slug/related';
    Uri uri = Uri.parse(Constants.apiUrl + 'shows/$parameter');
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
    return response.map((model) => Show.fromJson(model)).toList();
  }

  Future<List<Season>> getAllSeasonsForShow(
      {String slug, extended = false}) async {
    final parameter =
        (extended == true) ? '$slug/seasons?extended=full' : '$slug/seasons';
    Uri uri = Uri.parse(Constants.apiUrl + 'shows/$parameter');
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
    return response.map((model) => Season.fromJson(model)).toList();
  }

  Future<List<Episode>> getAllEpisodesOfSeason(
      {String slug, int number, extended = false}) async {
    final parameter = (extended == true) ? '?extended=full' : '';
    var uri =
        Uri.parse(Constants.apiUrl + 'shows/$slug/seasons/$number$parameter');

    var response = await client
        .get(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'trakt-api-version': Constants.apiVersionHeaderKey,
            'trakt-api-key': Constants.apiClientIdHeaderKey
          },
        )
        .then((resp) => json.decode(resp.body))
        .catchError((err) => print(err));

    return response.map((model) => Episode.fromJson(model)).toList();
  }
}

main(List<String> args) async {
  var a = TracktTvSeriesAPI(http.Client());

  // var resp = await a.getRelatedMovies(
  //   slug: 'tron-legacy-2010',
  //   extended: true,
  // );
  var resp = await a.getShowData(slug: 'elementary', extended: true);
  print(resp);
//  resp.forEach((f) => print(f.toJson()));
}
