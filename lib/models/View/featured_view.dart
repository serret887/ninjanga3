import 'package:flutter/material.dart';
import 'package:ninjanga3/models/View/poster_view.dart';

class FeaturedView {
  final String trailer;
  final List<String> genres;
  final PosterView poster;
  final String title;

  String getTitle() {
    return this.title == null ? "" : this.title;
  }

  FeaturedView(
      {@required this.trailer,
      @required this.genres,
      @required this.poster,
      @required this.title});

  String getImage() =>
      !poster.useBackDropImage() ? poster.backDropImage : poster.posterImage;
}
