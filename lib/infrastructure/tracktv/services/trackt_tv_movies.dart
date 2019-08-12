import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ninjanga3/infrastructure/tracktv/models/credits.dart';
import 'package:ninjanga3/infrastructure/tracktv/models/id.dart';
import 'package:ninjanga3/infrastructure/tracktv/models/movie_api.dart';
import 'package:ninjanga3/infrastructure/tracktv/models/movie_trackt_tv.dart';
import '../models/genre.dart';

import '../config_constants.dart';

enum GenreType { shows, movies }

class TracktTvMoviesAPI {
  final http.Client client;

  TracktTvMoviesAPI(this.client);

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
  Future<List<MovieApi>> getTrendingMoviesList(
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
    return response.map((model) => MovieApi.fromJson(model)).toList();
  }

  Future<MovieTrackTV> getMovieData({slug, extended = false}) async {
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

  Future<List<MovieTrackTV>> getRecomendedMovies({accessToken}) async {
    Uri uri = Uri.parse(Constants.apiUrl + 'recomendations/movies');

    var response = await client
        .get(
          uri,
          headers: {
            'Authorization': '$accessToken',
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
