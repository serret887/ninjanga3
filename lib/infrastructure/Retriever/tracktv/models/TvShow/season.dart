import 'package:json_annotation/json_annotation.dart';

import '../Common/id.dart';
import '../TvShow/episode.dart';

part "season.g.dart";

@JsonSerializable()
class Season {
  int number;
  Ids ids;
  List<Episode> episodes;

  Season({
    this.number,
    this.ids,
    this.episodes,
  });
  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonToJson(this);
}
