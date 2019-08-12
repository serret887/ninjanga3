import 'package:ninjanga3/infrastructure/tmdb/models/images_tmdb.dart';
import 'package:ninjanga3/infrastructure/tracktv/models/id.dart';

class MovieView {
  final String title;
  final int year;
  final Ids ids;
  final String tagline;
  final String overview;
  final String released;
  final String certification;
  final double rating;
  final String trailer;
  final List<String> genres;
  final String posterImage;
  final String backdrop;
  final int duration;

  MovieView(
      {this.title,
      this.year,
      this.ids,
      this.tagline,
      this.overview,
      this.released,
      this.certification,
      this.rating,
      this.trailer,
      this.genres,
      this.posterImage,
      this.backdrop,
      this.duration});
}
