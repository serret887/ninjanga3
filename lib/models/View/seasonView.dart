import 'package:flutter/material.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Common/id.dart';

import 'episode_poster_view.dart';

class SeasonView {
  final String title;
  final int year;
  final Ids ids;
  final String overview;
  final String certification;
  final double rating;
  final String trailer; //TODO maybe I have use for this later
  final List<String> genres;
  final String posterImage;
  final String backdrop;
  final int duration;
  final List<EpisodePosterView> episodesPosterView;
  final int seasonAmount;
  final int number;
  SeasonView({
    @required this.number,
    @required this.seasonAmount,
    @required this.title,
    @required this.year,
    @required this.ids,
    @required this.overview,
    @required this.certification,
    @required this.rating,
    @required this.trailer,
    @required this.genres,
    @required this.posterImage,
    @required this.backdrop,
    @required this.duration,
    @required this.episodesPosterView,
  });

  int getSeasonAmount() => seasonAmount == null ? 1 : seasonAmount;
}
