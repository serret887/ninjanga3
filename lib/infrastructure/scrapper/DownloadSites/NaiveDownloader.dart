import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:ninjanga/Models/MovieLinkInfo.dart';

class NaiveDownloader {
  RegExp _regExpVideoUri = new RegExp(
      r"((?!,).*)(((http(s)?):)(\/\/([^\/?#\s]*))((?!).)*([^?#\s]*)(\?([^#\s]*))?(#([^\s]*))?.mp4)");

  Future<MovieLinkInfo> download(MovieLinkInfo info) async {
    try {
      var response = await http.get(info.siteUri);
      var links = _getMP4Linksregex(response.body);
      info.videoUri.addAll(links);
      return info;
    } catch (e) {
      print("I need to report this thing: $e");
      return info;
    }
  }

  Set<Uri> _getLinksInsideVideo(Document body) => body
      .getElementsByTagName('video')
      .map((Element source) => source
          .getElementsByTagName('source')
          .map((Element e) => e?.attributes['src'])
          .map((String uri) => Uri.parse(uri))
          .toList())
      .expand((i) => i)
      .toSet();

  Set<Uri> _getMP4Linksregex(String response) => _regExpVideoUri
      .allMatches(response)
      .map((Match match) => Uri.tryParse(match.group(2)))
      .where((Uri uri) => uri != null)
      .toSet();
}

void main(List<String> args) async {
  var info = MovieLinkInfo(
      serverName: "asdf",
      detailsUri: Uri.parse("asdf"),
      imageUri: Uri.parse("asdf"));
  info.siteUri = Uri.parse(r"https://vidlox.tv/q3qc171vea43");
  await NaiveDownloader().download(info);
}
