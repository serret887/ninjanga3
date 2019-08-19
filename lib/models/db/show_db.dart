import 'package:json_annotation/json_annotation.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Common/id.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/TvShow/airs.dart';
import 'package:ninjanga3/models/View/episode_poster_view.dart';
import 'package:ninjanga3/models/View/featured_view.dart';
import 'package:ninjanga3/models/View/poster_view.dart';
import 'package:ninjanga3/models/View/seasonView.dart';
import 'package:ninjanga3/models/View/video_view.dart';

import 'baseDb.dart';
import 'episode_db.dart';

part 'show_db.g.dart';

@JsonSerializable()
class ShowDb extends BaseDb {
  final String title;
  final int year;
  final Ids ids;
  final String overview;
  final Airs airs;
  final int runtime;
  final String certification;
  final String network;
  final String trailer;
  final String status;
  final double rating;
  final String language;
  final List<String> availableTranslations;
  final List<String> genres;
  final int airedEpisodes;
  final String origin;
  final String posterImage;
  final String backdrop;
  final int duration;
  int seasonAmount;
  List<EpisodeDb> episodes;

  ShowDb(
      {this.episodes,
      this.title,
      this.year,
      this.ids,
      this.overview,
      this.airs,
      this.runtime,
      this.certification,
      this.network,
      this.trailer,
      this.status,
      this.rating,
      this.language,
      this.availableTranslations,
      this.genres,
      this.airedEpisodes,
      this.backdrop,
      this.posterImage,
      this.origin,
      this.duration})
      : super(title, year, ids) {}

  bool containsEpisodesForSeason(int number) {
    if (episodes == null) return false;
    return episodes.any((e) => e.season == number);
  }

  SeasonView getSeasonView({int number}) => SeasonView(
        number: number,
        overview: overview,
        title: title,
        posterImage: posterImage,
        ids: ids,
        genres: genres,
        backdrop: backdrop,
        certification: certification,
        duration: duration,
        episodesPosterView: episodes
            .map<EpisodePosterView>((e) => e.getEpisodePosterView(posterImage))
            .toList(),
        rating: rating,
        trailer: trailer,
        year: year,
        seasonAmount: seasonAmount,
      );

  PosterView getPosterView() => PosterView(
      backDropImage: this.backdrop,
      posterImage: this.posterImage,
      slug: this.ids.slug,
      rating: this.rating,
      isMovie: false,
      origin: this.origin);

  addEpisodes(List<EpisodeDb> epdisodes) {
    if (this.episodes != null) {
      var temp = List<EpisodeDb>();
      temp.addAll(epdisodes);
      temp.addAll(this.episodes);
      this.episodes = temp;
    } else
      this.episodes = epdisodes;
  }

  ShowDb clone() {
    return ShowDb(
        episodes: this.episodes,
        title: this.title,
        year: this.year,
        ids: this.ids,
        overview: this.overview,
        airs: this.airs,
        runtime: this.runtime,
        certification: this.certification,
        network: this.network,
        trailer: this.trailer,
        status: this.status,
        rating: this.rating,
        language: this.language,
        availableTranslations: this.availableTranslations,
        genres: this.genres,
        airedEpisodes: this.airedEpisodes,
        backdrop: this.backdrop,
        posterImage: this.posterImage,
        origin: this.origin,
        duration: this.duration);
  }

  VideoView getTrailerVideo() =>
      VideoView(title: this.title, url: this.trailer);

  FeaturedView getFeaturedView() => FeaturedView(
      genres: genres, trailer: trailer, poster: getPosterView(), title: title);

  factory ShowDb.fromJson(Map<String, dynamic> json) => _$ShowDbFromJson(json);

  Map<String, dynamic> toJson() => _$ShowDbToJson(this);
}
