import 'package:flutter/material.dart';
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
  int seasonAmount;

  SeasonDb({
    @required this.title,
    @required this.year,
    @required this.posterImage,
    @required this.backdrop,
    @required this.number,
    @required this.ids,
    @required this.episodes,
  }) : super(title, year, ids);

  factory SeasonDb.fromJson(Map<String, dynamic> json) =>
      _$SeasonDbFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonDbToJson(this);
}
