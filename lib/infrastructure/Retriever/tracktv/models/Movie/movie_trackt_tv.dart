import '../Common/id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_trackt_tv.g.dart';

@JsonSerializable()
class MovieTrackTV {
  String title;
  int year;
  Ids ids;
  String tagline;
  String overview;
  String released;
  int runtime;
  String country;
  String updatedAt;
  String trailer;
  String homepage;
  double rating;
  int votes;
  int commentCount;
  String language;
  List<String> availableTranslations;
  List<String> genres;
  String certification;
  MovieTrackTV({
    this.title,
    this.year,
    this.ids,
    this.tagline,
    this.overview,
    this.released,
    this.runtime,
    this.country,
    this.updatedAt,
    this.trailer,
    this.homepage,
    this.rating,
    this.votes,
    this.commentCount,
    this.language,
    this.availableTranslations,
    this.genres,
    this.certification,
  });

  factory MovieTrackTV.fromJson(Map<String, dynamic> json) =>
      _$MovieTrackTVFromJson(json);
  Map<String, dynamic> toJson() => _$MovieTrackTVToJson(this);
}
