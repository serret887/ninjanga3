import 'package:json_annotation/json_annotation.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Common/id.dart';

@JsonSerializable()
class SkinnyShow {
  final String title;
  final int year;
  final Ids ids;

  SkinnyShow({this.title, this.year, this.ids});
  factory SkinnyShow.fromJson(Map<String, dynamic> json) => SkinnyShow(
        title: json["title"],
        year: json["year"],
        ids: Ids.fromJson(json["ids"]),
      );
}
