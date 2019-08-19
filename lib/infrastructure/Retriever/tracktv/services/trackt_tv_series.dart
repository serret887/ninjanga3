import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/TvShow/SkinnyShow.dart';

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
    return await response.map<Show>((show) => Show.fromJson(show)).toList();
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

    return await response
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
    var show = Show.fromJson(response);
    show.seasonAmount = await getAmountOfSeasonsForShow(slug: slug);
    return show;
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
    return resp.map<Show>((mov) => Show.fromJson(mov)).toList();
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
//    var a = response.map<Show>((mov) => Show.fromJson(mov)).toList();
    var skinny =
        response.map<SkinnyShow>((mov) => SkinnyShow.fromJson(mov)).toList();
    return skinny
        .map<Show>(
            (mov) => Show(title: mov.title, year: mov.year, ids: mov.ids))
        .toList();
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
    return response.map<Season>((model) => Season.fromJson(model)).toList();
  }

  Future<int> getAmountOfSeasonsForShow({
    String slug,
  }) async {
    var allSeason = await getAllSeasonsForShow(slug: slug);
    var seasonNumber = allSeason.map((s) => s.number).reduce(max);
    return seasonNumber;
  }

//  Future<List<Episode>> getSingleSeasonsForShow(
//      {String slug, extended = true, number = 1}) async {
//    final parameter = (extended == true)
//        ? '$slug/seasons/$number?extended=full'
//        : '$slug/seasons/$number';
//    Uri uri = Uri.parse(Constants.apiUrl + 'shows/$parameter');
//Iterable response = await client
//        .get(
//          uri,
//          headers: {
//            'Content-Type': 'application/json',
//            'trakt-api-version': Constants.apiVersionHeaderKey,
//            'trakt-api-key': Constants.apiClientIdHeaderKey
//          },
//        )
//        .then((resp) => json.decode(resp.body))
//        .catchError((err) => print('error single season  - $err'));
//    return response.map((resp)=> Episode.fromJson(resp));
//  }

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

    return response.map<Episode>((model) => Episode.fromJson(model)).toList();
  }
}

main(List<String> args) async {
  var a = TracktTvSeriesAPI(http.Client());

  // var resp = await a.getRelatedMovies(
  //   slug: 'tron-legacy-2010',
  //   extended: true,
  // );
  var resp = await a.getAmountOfSeasonsForShow(
    slug: 'elementary',
  );
  print(resp);
//  resp.forEach((f) => print(f.toJson()));
}
