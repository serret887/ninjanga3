import 'id.dart';
import 'movie_trackt_tv.dart';

class MovieApi {
  int watchers;
  MovieTrackTV movie;

  MovieApi({this.watchers, this.movie});

  MovieApi.fromJson(Map<String, dynamic> json, {bool movieType = true}) {
    watchers = json['watchers'];
    var type = movieType ? "movie" : "show";
    movie = json[type] != null ? MovieTrackTV.fromJson(json[type]) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['watchers'] = this.watchers;
    if (this.movie != null) {
      data['movie'] = this.movie.toJson();
    }
    return data;
  }
}
