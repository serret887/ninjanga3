import 'package:ninjanga3/models/View/featured_view.dart';
import 'package:ninjanga3/models/View/movie_view.dart';
import 'package:ninjanga3/models/View/poster_view.dart';
import 'package:ninjanga3/models/db/baseDb.dart';

import 'package:json_annotation/json_annotation.dart';

part 'movieDb.g.dart';

@JsonSerializable()
class MovieDb extends BaseDb {
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
      {title,
      year,
      ids,
      this.tagline,
      this.overview,
      this.certification,
      this.rating,
      this.trailer,
      this.genres,
      this.posterImage,
      this.backdrop,
      this.duration,
      this.origin})
      : super(title, year, ids);

  MovieView getMovieView() => MovieView(
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
      posterImage: this.posterImage,
      slug: this.ids.slug,
      rating: this.rating,
      isMovie: true);

  PosterView getFeaturedView() => FeaturedView(
      genre: genres, trailer: trailer, poster: this.getPosterView());

  factory MovieDb.fromJson(Map<String, dynamic> json) =>
      _$MovieDbFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDbToJson(this);
}
