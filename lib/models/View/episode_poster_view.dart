import 'package:flutter/material.dart';

class EpisodePosterView {
  final String title;
  final int number;
  final double raiting;
  final String poster;
  final String overview;
  final int duration;

  String getTitle() {
    return this.title == null ? "" : this.title;
  }

  String getOverView() {
    return this.overview == null ? "" : this.overview;
  }

  EpisodePosterView(
      {@required this.title,
      @required this.number,
      @required this.raiting,
      @required this.poster,
      @required this.overview,
      @required this.duration});
}
