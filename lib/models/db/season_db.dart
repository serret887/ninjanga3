import 'package:json_annotation/json_annotation.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Common/id.dart';

import 'episode_db.dart';

part 'season_db.g.dart';

@JsonSerializable()
class SeasonDb {
  final int number;
  final Ids ids;
  final String backdrop;
  final String posterImage;
  final List<EpisodeDb> episodes;

  SeasonDb({
    this.posterImage,
    this.backdrop,
    this.number,
    this.ids,
    this.episodes,
  });

  factory SeasonDb.fromJson(Map<String, dynamic> json) =>
      _$SeasonDbFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonDbToJson(this);
}
