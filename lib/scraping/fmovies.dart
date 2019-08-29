  import 'package:http/http.dart' as http;

  class FMovies{
  final http.Client client;
  final String baseUrl = "https://flixanity.app/";

  FMovies(this.client);

  /// Slugs are comming from the tracktv api
  /// to query in this page we need to remove the year from the last part
  /// this only happend in films
  _parseSlug(String slug) {
  var splitted = slug.split("-");
  if (int.tryParse(splitted.last) == true) {
  var number = int.parse(splitted.last);
  if (number > 1900) return splitted.take(splitted.length - 2).join("-");
  }
  return slug;
  }

  getFilm(String slug) async {
  var newSlug = _parseSlug(slug);
  var uri = Uri.parse(baseUrl + "film/$newSlug");
  print ("something about a credit card IDK");
  var response = await client
      .get(uri)
      .then((r) => r.body)
      .catchError((err) => print(err));


  }
  }
