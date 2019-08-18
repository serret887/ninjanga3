import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
    @required this.posterImage,
    @required this.backdrop,
    @required this.season,
    @required this.number,
    @required this.title,
    @required this.ids,
    @required this.numberAbs,
    @required this.overview,
    @required this.rating,
    @required this.votes,
    @required this.commentCount,
    @required this.firstAired,
    @required this.updatedAt,
    @required this.availableTranslations,
    @required this.runtime,
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

  EpisodePosterView getEpisodePosterView(String poster) {
    String image = poster;

    if (!posterImage.contains("null"))
      image = posterImage;
    else if (!backdrop.contains("null")) image = backdrop;
    return EpisodePosterView(
        number: number,
        title: title,
        overview: overview,
        poster: image,
        raiting: rating,
        duration: runtime);
  }

  factory EpisodeDb.fromJson(Map<String, dynamic> json) =>
      _$EpisodeDbFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeDbToJson(this);
}
