import 'package:flutter/material.dart';

class PosterView {
  final String posterImage;
  final String slug;
  final double rating;
  final bool isMovie;
  final String origin;
  final String backDropImage;

  PosterView(
      {this.backDropImage,
      @required this.posterImage,
      @required this.slug,
      @required this.rating,
      @required this.isMovie,
      @required this.origin});

  bool useBackDropImage() => posterImage == null ? true : false;

  String getImage() => useBackDropImage() ? backDropImage : posterImage;
}
