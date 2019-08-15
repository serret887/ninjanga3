import '../Movie/movie_trackt_tv.dart';
import '../TvShow/show.dart';

class Trending<T> {
  int watchers;
  T movie;

  Trending({this.watchers});

  Trending.fromJson(Map<String, dynamic> json, {bool movieType = true}) {
    watchers = json['watchers'];
    var type = "";
    if (T is MovieTrackTV) {
      movie =
          json['movie'] != null ? MovieTrackTV.fromJson(json[type]) as T : null;
    } else if (T is Show) {
      movie = json['show'] != null ? Show.fromJson(json[type]) as T : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['watchers'] = this.watchers;
    if (this.movie is MovieTrackTV) {
      data['movie'] = (this.movie as MovieTrackTV).toJson();
    } else if (this.movie is Show) {
      data['show'] = (this.movie as Show).toJson();
    }
    return data;
  }
}
