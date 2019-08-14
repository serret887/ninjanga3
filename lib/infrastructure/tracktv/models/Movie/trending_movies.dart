import 'package:ninjanga3/infrastructure/tracktv/models/Movie/movie_trackt_tv.dart';

class TrendingMovies {
  int watchers;
  MovieTrackTV movie;

  TrendingMovies({this.watchers, this.movie});

  TrendingMovies.fromJson(Map<String, dynamic> json, {bool movieType = true}) {
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
