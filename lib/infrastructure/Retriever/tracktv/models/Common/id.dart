import 'package:json_annotation/json_annotation.dart';
part 'id.g.dart';

@JsonSerializable()
class Ids {
  int trakt;
  String slug;
  String imdb;
  int tmdb;

  Ids({this.trakt, this.slug, this.imdb, this.tmdb});

  factory Ids.fromJson(Map<String, dynamic> json) => _$IdsFromJson(json);
  Map<String, dynamic> toJson() => _$IdsToJson(this);
}
