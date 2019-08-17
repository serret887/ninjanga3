import 'package:json_annotation/json_annotation.dart';

import '../Movie/movie_trackt_tv.dart';
import '../TvShow/show.dart';

part 'trending.g.dart';

@JsonSerializable()
class Trending {
  int watchers;
  MovieTrackTV movie;
  Show show;

  Trending({this.watchers, this.movie, this.show});

  factory Trending.fromJson(Map<String, dynamic> json) =>
      _$TrendingFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingToJson(this);
}
