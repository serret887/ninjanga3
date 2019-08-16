import 'package:ninjanga3/models/View/poster_view.dart';

class FeaturedView extends PosterView {
  final String trailer;
  final List<String> genre;
  final PosterView poster;

  FeaturedView({this.trailer, this.genre, this.poster});
}
