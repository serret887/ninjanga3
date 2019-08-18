import 'package:flutter/material.dart';

class EpisodePosterView {
  final String title;
  final int number;
  final double raiting;
  final String poster;
  final String overview;
  final int duration;

  EpisodePosterView(
      {@required this.title,
      @required this.number,
      @required this.raiting,
      @required this.poster,
      @required this.overview,
      @required this.duration});
}
