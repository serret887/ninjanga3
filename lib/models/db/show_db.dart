import 'package:json_annotation/json_annotation.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/TvShow/airs.dart';
import 'package:ninjanga3/models/View/featured_view.dart';
import 'package:ninjanga3/models/View/poster_view.dart';
import 'package:ninjanga3/models/View/video_view.dart';

import 'baseDb.dart';

part 'show_db.g.dart';

@JsonSerializable()
class ShowDb extends BaseDb {
  final DateTime firstAired;
  final String overview;
  final Airs airs;
  final int runtime;
  final String certification;
  final String network;
  final String country;
  final String trailer;
  final String homepage;
  final String status;
  final double rating;
  final int votes;
  final int commentCount;
  final DateTime updatedAt;
  final String language;
  final List<String> availableTranslations;
  final List<String> genres;
  final int airedEpisodes;
  final String origin;
  final String posterImage;
  final String backdrop;

  ShowDb({
    title,
    year,
    ids,
    this.overview,
    this.firstAired,
    this.airs,
    this.runtime,
    this.certification,
    this.network,
    this.country,
    this.trailer,
    this.homepage,
    this.status,
    this.rating,
    this.votes,
    this.commentCount,
    this.updatedAt,
    this.language,
    this.availableTranslations,
    this.genres,
    this.airedEpisodes,
    this.backdrop,
    this.posterImage,
    this.origin,
  }) : super(title, year, ids);

  PosterView getPosterView() => PosterView(
      backDropImage: this.backdrop,
      posterImage: this.posterImage,
      slug: this.ids.slug,
      rating: this.rating,
      isMovie: true,
      origin: this.origin);

  VideoView getTrailerVideo() =>
      VideoView(title: this.title, url: this.trailer);

  FeaturedView getFeaturedView() => FeaturedView(
      genres: genres, trailer: trailer, poster: getPosterView(), title: title);

  factory ShowDb.fromJson(Map<String, dynamic> json) => _$ShowDbFromJson(json);

  Map<String, dynamic> toJson() => _$ShowDbToJson(this);
}
