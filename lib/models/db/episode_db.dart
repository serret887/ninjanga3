import 'package:json_annotation/json_annotation.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Common/id.dart';

part 'episode_db.g.dart';

@JsonSerializable()
class EpisodeDb {
  final int season;
  final int number;
  final String title;
  final Ids ids;
  final int numberAbs;
  final String overview;
  final double rating;
  final int votes;
  final int commentCount;
  final DateTime firstAired;
  final DateTime updatedAt;
  final List<String> availableTranslations;
  final int runtime;
  final String posterImage;
  final String backdrop;

  EpisodeDb({
    this.posterImage,
    this.backdrop,
    this.season,
    this.number,
    this.title,
    this.ids,
    this.numberAbs,
    this.overview,
    this.rating,
    this.votes,
    this.commentCount,
    this.firstAired,
    this.updatedAt,
    this.availableTranslations,
    this.runtime,
  });

  factory EpisodeDb.fromJson(Map<String, dynamic> json) =>
      _$EpisodeDbFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeDbToJson(this);
}
