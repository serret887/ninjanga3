import 'package:flutter/material.dart';

import 'detail_description_view.dart';
import 'episode_poster_view.dart';

class SeasonView {
  final DetailDescriptionView descriptionView;
  final List<EpisodePosterView> episodesPosterView;
  final int seasonAmount;
  final int number;

  SeasonView({
    @required this.number,
    @required this.seasonAmount,
    @required this.descriptionView,
    @required this.episodesPosterView,
  });

  int getSeasonAmount() => seasonAmount == null ? 1 : seasonAmount;
}
