import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Common/id.dart';

import 'poster_view.dart';

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
  final bool isMovie;
  final String origin;

  SeasonView(
      {this.title,
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
      this.isMovie,
      this.origin});

  PosterView getPosterView() {
    return PosterView(
        posterImage: this.posterImage,
        slug: this.ids.slug,
        rating: this.rating,
        isMovie: this.isMovie);
  }

  static SeasonView fromJson(Map<String, dynamic> map) {
    return SeasonView(
      title: map['title'],
      year: map['year'],
      ids: Ids.fromJson(map['ids']),
      overview: map['overview'],
      certification: map['certification'],
      rating: map['rating'],
      trailer: map['trailer'],
      genres: List<String>.from(
        map['genres'].map((x) => x),
      ),
      posterImage: map['posterImage'],
      backdrop: map['backdrop'],
      duration: map['duration'],
      origin: map['origin'],
      isMovie: map['isMovie'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'year': year,
      'ids': ids.toJson(),
      'overview': overview,
      'certification': certification,
      'rating': rating,
      'trailer': trailer,
      'genres': List<dynamic>.from(genres.map((x) => x)),
      'posterImage': posterImage,
      'backdrop': backdrop,
      'duration': duration,
      'origin': origin,
      'isMovie': isMovie,
    };
  }
}