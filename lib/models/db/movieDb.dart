import 'package:json_annotation/json_annotation.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Common/id.dart';
import 'package:ninjanga3/models/View/featured_view.dart';
import 'package:ninjanga3/models/View/movie_view.dart';
import 'package:ninjanga3/models/View/poster_view.dart';
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

  MovieDb({this.title,
    this.year,
    this.ids,
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
      backDropImage: this.backdrop,
      posterImage: this.posterImage,
      slug: this.ids.slug,
      rating: this.rating,
      isMovie: true,
      origin: this.origin
  );

  FeaturedView getFeaturedView() =>
      FeaturedView(
          genres: genres,
          trailer: trailer,
          poster: getPosterView(),
          title: title);

  factory MovieDb.fromJson(Map<String, dynamic> json) =>
      _$MovieDbFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDbToJson(this);
}
