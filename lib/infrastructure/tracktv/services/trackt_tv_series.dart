import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ninjanga3/infrastructure/tracktv/models/episode.dart';
import 'package:ninjanga3/infrastructure/tracktv/models/movie_api.dart';
import 'package:ninjanga3/infrastructure/tracktv/models/movie_trackt_tv.dart';
import 'package:ninjanga3/infrastructure/tracktv/models/season.dart';

import '../config_constants.dart';

class TracktTvSeriesAPI {
  final http.Client client;

  TracktTvSeriesAPI(this.client);

  Future<List<MovieTrackTV>> getPopularTvShowList(
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
    return response.map((model) => MovieTrackTV.fromJson(model)).toList();
  }

  /// type can be changed for
  /// played, watched, popular, trending, boxOffice
  Future<List<MovieTrackTV>> getTrendingTvShowList(
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
    return response
        .map((model) => MovieApi.fromJson(model, movieType: false))
        .map((mov) => mov.movie)
        .toList();
  }

  Future<MovieTrackTV> getShowData({slug, extended = true}) async {
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
    return MovieTrackTV.fromJson(response);
  }

  Future<List<MovieTrackTV>> getRecomendedShows(
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
    return resp.map((model) => MovieTrackTV.fromJson(model)).toList();
  }

  Future<List<MovieTrackTV>> getRelatedShows(
      {String slug, extended = false}) async {
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
    return response.map((model) => MovieTrackTV.fromJson(model)).toList();
  }

  Future<List<SeasonTracktv>> getAllSeasonsForShow(
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
    return response.map((model) => SeasonTracktv.fromJson(model)).toList();
  }

  Future<SeasonTracktv> getAllEpisodesOfSeason(
      {SeasonTracktv seasonTracktv, extended = false}) async {
    final parameter = (extended == true) ? '?extended=full' : '';
    var uris = seasonTracktv.episodes.map((episode) =>
        Uri.parse(Constants.apiUrl +
            'shows/${seasonTracktv.ids.slug}/seasons/${seasonTracktv
                .number}/episodes/${episode.number}$parameter'));

    var futures = uris.map((uri) async =>
    await client
        .get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'trakt-api-version': Constants.apiVersionHeaderKey,
        'trakt-api-key': Constants.apiClientIdHeaderKey
      },
    )
        .then(((resp) => json.decode(resp.body)))
        .catchError((err) => print(err)));
    var response = await Future.wait(futures);
    seasonTracktv.episodes =
        response.map((model) => Episode.fromJson(model)).toList();
//todo not like because is mutable
    return seasonTracktv;
  }

  Future<MovieTrackTV> fillCrewData(MovieTrackTV movieTrackTV) {}
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
