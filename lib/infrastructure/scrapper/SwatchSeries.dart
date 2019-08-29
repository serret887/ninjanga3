import 'dart:convert';

import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:ninjanga/Models/MovieLinkInfo.dart';
import 'package:ninjanga/Services/DownloadSites/NaiveDownloader.dart';

class SwatchSeriesService {
  Future<List<Future<MovieLinkInfo>>> fetch(String url) async {
    http.Response response = await http.get(url);

    Document document = parser.parse(response.body);

    var movieInfo = document
        .getElementById("myTable")
        .getElementsByTagName('tr')
        .map((Element row) => _createMovieLinkInfo(row))
        .where((MovieLinkInfo info) => info != null)
        .map((MovieLinkInfo movie) async => await _setMovieLink(movie))
        .toList();
    return movieInfo;
  }

  MovieLinkInfo _createMovieLinkInfo(Element row) {
    List<Element> r = row.getElementsByTagName('td').toList();

    var imageSite = r[0].getElementsByTagName('img')[0].attributes['src'];
    var siteName = r[0].text.trim();
    var siteUrl = r[1]
        .getElementsByTagName('a')
        .map((Element e) => e?.attributes['href'])
        .toList();
    if (siteUrl.length != 1) return null;

    return MovieLinkInfo(
        serverName: siteName,
        imageUri: Uri.parse(imageSite),
        detailsUri: Uri.parse(siteUrl.single));
  }

  Future<MovieLinkInfo> _setMovieLink(MovieLinkInfo movie) async {
    var parameters = movie.detailsUri.queryParameters.values.first;
    var decodedURL = base64.decode(parameters);
    movie.siteUri = Uri.parse(String.fromCharCodes(decodedURL));
    return movie;
  }
}

void main(List<String> args) async {
  var movies = await SwatchSeriesService().fetch(
      "https://www1.swatchseries.to/episode/fear_the_walking_dead_s5_e5.html");
  var n = NaiveDownloader();
  var moviesInfo = await Future.wait(
      movies.map((Future<MovieLinkInfo> mov) async => await mov).toList());

  var moviesFull = await Future.wait(moviesInfo
      .map((MovieLinkInfo info) async => await n.download(info))
      .toList());
  moviesFull
      .map((m) => "$m")
      .where((String m) => m.isNotEmpty)
      .forEach((m) => print(m));
}
