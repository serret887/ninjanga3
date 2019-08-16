class PosterView {
  final String posterImage;
  final String slug;
  final double rating;
  final bool isMovie;
  final String origin;
  final String backDropImage;

  PosterView({this.backDropImage,
    this.posterImage,
    this.slug,
    this.rating,
    this.isMovie,
    this.origin});

  bool useBackDropImage() => posterImage == null ? true : false;


  String getImage() => useBackDropImage() ? backDropImage : posterImage;
}
