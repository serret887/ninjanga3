import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Common/id.dart';
import 'package:ninjanga3/models/db/season_db.dart';
import 'package:ninjanga3/models/db/show_db.dart';

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

  SeasonView({
    this.seasonAmount,
    this.title,
    this.year,
    this.ids,
    this.overview,
    this.certification,
    this.rating,
    this.trailer,
    this.genres,
    this.posterImage,
    this.backdrop,
    this.duration,
    this.episodesPosterView,
  });

  factory SeasonView.fromDb(ShowDb show, SeasonDb season) =>
      SeasonView(
        overview: show.overview,
        title: show.title,
        posterImage: show.posterImage,
        ids: season.ids,
        genres: show.genres,
        backdrop: show.backdrop,
        certification: show.certification,
        duration: show.duration,
        episodesPosterView: season.episodes
            .map<EpisodePosterView>((e) => e.getEpisodePosterView())
            .toList(),
        rating: show.rating,
        trailer: show.trailer,
        year: show.year,
        seasonAmount: show.seasonAmount,
      );
}
