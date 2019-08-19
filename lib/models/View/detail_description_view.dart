import 'package:flutter/widgets.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Common/id.dart';

class DetailDescriptionView {
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

  String getTitle() {
    return this.title == null ? "" : this.title;
  }

  String getOverView() {
    return this.overview == null ? "" : this.overview;
  }

  DetailDescriptionView(
      {@required this.title,
      @required this.year,
      @required this.ids,
      this.tagline,
      @required this.overview,
      @required this.certification,
      @required this.rating,
      @required this.trailer,
      @required this.genres,
      @required this.posterImage,
      @required this.backdrop,
      @required this.duration,
      this.isMovie,
      @required this.origin});
}
