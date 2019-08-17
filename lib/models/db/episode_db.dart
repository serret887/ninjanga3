import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Common/id.dart';
import 'package:ninjanga3/models/View/episode_poster_view.dart';

part 'episode_db.g.dart';

@JsonSerializable()
class EpisodeDb extends Equatable {
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
  }) : super([
    posterImage,
    backdrop,
    season,
    number,
    title,
    ids,
    numberAbs,
    overview,
    rating,
    votes,
    commentCount,
    firstAired,
    updatedAt,
    availableTranslations,
    runtime,
  ]);

  EpisodePosterView getEpisodePosterView() {
    return EpisodePosterView(
        number: number,
        title: title,
        overview: overview,
        poster: backdrop,
        raiting: rating);
  }

  factory EpisodeDb.fromJson(Map<String, dynamic> json) =>
      _$EpisodeDbFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeDbToJson(this);
}
