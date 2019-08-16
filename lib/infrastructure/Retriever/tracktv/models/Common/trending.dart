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

  factory Trending.fromJson(Map<String, dynamic> json) =>
      _$TrendingFromJson(json);
  Map<String, dynamic> toJson() => _$TrendingToJson(this);
}
