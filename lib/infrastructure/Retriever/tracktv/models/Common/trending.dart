import '../Movie/movie_trackt_tv.dart';
import '../TvShow/show.dart';

import 'package:json_annotation/json_annotation.dart';
part 'trending.g.dart';

@JsonSerializable()
class Trending {
  int watchers;
  MovieTrackTV movie;
  Show serie;

  Trending({this.watchers, this.movie, this.serie});

  factory Trending.fromJson(
    Map<String, dynamic> json,
  ) {
    return new Trending(
        watchers: json['watchers'],
        movie:
            json['movie'] != null ? MovieTrackTV.fromJson(json['movie']) : null,
        serie: json['show'] != null ? Show.fromJson(json['show']) : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['watchers'] = this.watchers;
    data['movie'] = this.movie?.toJson();
    data['show'] = this.serie?.toJson();
    return data;
  }
}
