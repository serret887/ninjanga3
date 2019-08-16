import 'package:ninjanga3/models/View/poster_view.dart';

class FeaturedView {
  final String trailer;
  final List<String> genres;
  final PosterView poster;
  final String title;

  FeaturedView({this.trailer, this.genres, this.poster, this.title});

  String getImage() =>
      !poster.useBackDropImage() ? poster.backDropImage : poster.posterImage;
}
