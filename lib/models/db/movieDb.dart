import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Common/id.dart';
import 'package:ninjanga3/models/View/detail_description_view.dart';
import 'package:ninjanga3/models/View/featured_view.dart';
import 'package:ninjanga3/models/View/poster_view.dart';
import 'package:ninjanga3/models/View/video_view.dart';
import 'package:ninjanga3/models/db/baseDb.dart';

part 'movieDb.g.dart';

@JsonSerializable()
class MovieDb extends BaseDb {
  final String title;
  final int year;
  final Ids ids;
  final String tagline; //TODO put it below the title
  final String overview;
  final String certification;
  final double rating;
  final String trailer; //TODO maybe I have use for this later
  final List<String> genres;
  final String posterImage;
  final String backdrop;
  final int duration;
  final String origin;

  MovieDb(
      {@required this.title,
      @required this.year,
      @required this.ids,
      @required this.tagline,
      @required this.overview,
      @required this.certification,
      @required this.rating,
      @required this.trailer,
      @required this.genres,
      @required this.posterImage,
      @required this.backdrop,
      @required this.duration,
      @required this.origin})
      : super(title, year, ids);

  DetailDescriptionView getMovieView() => DetailDescriptionView(
        isMovie: true,
        backdrop: backdrop,
        certification: certification,
        genres: genres,
        ids: ids,
        overview: overview,
        posterImage: posterImage,
        rating: rating,
        tagline: tagline,
        title: title,
        trailer: trailer,
        year: year,
        duration: duration,
        origin: origin,
      );

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

  factory MovieDb.fromJson(Map<String, dynamic> json) =>
      _$MovieDbFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDbToJson(this);
}
