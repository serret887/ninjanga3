import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Common/id.dart';

import 'poster_view.dart';

class MovieView {
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
  final bool isMovie;
  final String origin;

  MovieView(
      {this.title, this.year, this.ids, this.tagline, this.overview, this.certification, this.rating, this.trailer, this.genres, this.posterImage, this.backdrop, this.duration, this.isMovie, this.origin});


  PosterView getPosterView() {
    return PosterView(
        posterImage: this.posterImage,
        slug: this.ids.slug,
        rating: this.rating,
        isMovie: this.isMovie);
  }

  static MovieView fromJson(Map<String, dynamic> map) {
    return MovieView(
      title: map['title'],
      year: map['year'],
      ids: Ids.fromJson(map['ids']),
      tagline: map['tagline'],
      overview: map['overview'],
      certification: map['certification'],
      rating: map['rating'],
      trailer: map['trailer'],
      genres: List<String>.from(map['genres'].map((x) => x),),
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
      'tagline': tagline,
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
