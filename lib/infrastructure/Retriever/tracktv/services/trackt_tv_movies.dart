import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config_constants.dart';
import '../models/Common/trending.dart';
import '../models/Movie/movie_trackt_tv.dart';

enum GenreType { shows, movies }

class TracktTvMoviesAPI {
  final http.Client client;

  TracktTvMoviesAPI(this.client);

  Future<List<MovieTrackTV>> getPopularMoviesList(
      {int page = 0, int pageLimit = 10, bool extended = false}) async {
    final parameter = (extended == true)
        ? 'movies/popular?extended=full&page=$page&limit=$pageLimit'
        : 'movies/popular?page=$page&limit=$pageLimit';

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
  Future<List<MovieTrackTV>> getTrendingMoviesList(
      {int page = 0, int pageLimit = 10, bool extended = false}) async {
    final parameter = (extended == true)
        ? 'movies/trending?extended=full&page=$page&limit=$pageLimit'
        : 'movies/trending?page=$page&limit=$pageLimit';

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
        .map((model) => Trending.fromJson(model))
        .map((mov) => mov.movie)
        .toList();
  }

  Future<MovieTrackTV> getMovieData({slug, extended = true}) async {
    final parameter = (extended == true) ? '$slug?extended=full' : '$slug';

    Uri uri = Uri.parse(Constants.apiUrl + 'movies/$parameter');

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
    //TODO save the state of the pagination
    return MovieTrackTV.fromJson(response);
  }

  Future<List<MovieTrackTV>> getRecomendedMovies(
      {String accessToken, page = 0, pageLimit = 10}) async {
    Uri uri =
        Uri.parse(Constants.apiUrl + 'recommendations/movies?limit=$pageLimit');

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

  Future<List<MovieTrackTV>> getRelatedMovies(
      {String slug, extended = false}) async {
    final parameter =
        (extended == true) ? '$slug/related?extended=full' : '$slug/related';
    Uri uri = Uri.parse(Constants.apiUrl + 'movies/$parameter');
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

  Future<MovieTrackTV> fillCrewData(MovieTrackTV movieTrackTV) {}
}

main(List<String> args) async {
  var a = TracktTvMoviesAPI(http.Client());

  var resp = await a.getRelatedMovies(
    slug: 'tron-legacy-2010',
    extended: true,
  );

  resp.forEach((f) => print(f.toJson()));
}
