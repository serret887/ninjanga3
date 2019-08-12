import 'id.dart';
import 'movie_trackt_tv.dart';

class MovieApi {
  int watchers;
  MovieTrackTV movie;

  MovieApi({this.watchers, this.movie});

  MovieApi.fromJson(Map<String, dynamic> json) {
    watchers = json['watchers'];
    movie =
        json['movie'] != null ? new MovieTrackTV.fromJson(json['movie']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['watchers'] = this.watchers;
    if (this.movie != null) {
      data['movie'] = this.movie.toJson();
    }
    return data;
  }
}
