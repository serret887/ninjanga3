import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'movie.dart';

class Tubi{
  final http.Client client;
  static const baseUrl = 'https://uapi.adrise.tv';
  Map<String, String> _headers = {
    "Accept-Encoding": "deflate, gzip;q=1.0, *;q=0.5"
  };

  Tubi(this.client);

  Future<List<Movie>> movieSearch({@required String key}) async {
    final url =
        '$baseUrl/cms/search?app_id=tubitv&categorize=true&device_id=3B17D64C-8A40-4234-A80E-0C3020F621B7&page_enabled=false&platform=iphone&search=$key&user_id=0';
    final response = await this.client.get(url, headers: _headers);

    if (response.statusCode != 200) {
      throw Exception('error searching movies');
    }
    final json = jsonDecode(response.body);

    var moviesJson = (json['contents'] as Map<String, dynamic>);
    var movies = Map<String, Movie>();
    moviesJson.forEach((k, v) {
      movies[k] = Movie.fromJson(v);
    });

    return movies.values.toList();
  }
}
