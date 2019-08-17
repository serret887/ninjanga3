import 'package:json_annotation/json_annotation.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Common/id.dart';

import 'baseDb.dart';
import 'episode_db.dart';

part 'season_db.g.dart';

@JsonSerializable()
class SeasonDb extends BaseDb {
  final String title;
  final int year;
  final int number;
  final Ids ids;
  final String backdrop;
  final String posterImage;
  final Set<EpisodeDb> episodes;

  SeasonDb({this.title, this.year,
    this.posterImage,
    this.backdrop,
    this.number,
    this.ids,
    this.episodes,
  }) : super(title, year, ids);

  factory SeasonDb.fromJson(Map<String, dynamic> json) =>
      _$SeasonDbFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonDbToJson(this);
}
