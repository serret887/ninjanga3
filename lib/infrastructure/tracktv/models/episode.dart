import 'id.dart';

class Episode {
  int season;
  int number;
  String title;
  Ids ids;
  int numberAbs;
  String overview;
  double rating;
  int votes;
  int commentCount;
  DateTime firstAired;
  DateTime updatedAt;
  List<String> availableTranslations;
  int runtime;

  Episode({
    this.season,
    this.number,
    this.title,
    this.ids,
    this.numberAbs,
    this.overview,
    this.rating,
    this.votes,
    this.commentCount,
    this.firstAired,
    this.updatedAt,
    this.availableTranslations,
    this.runtime,
  });

  factory Episode.fromJson(Map<String, dynamic> json) =>
      new Episode(
        season: json["season"],
        number: json["number"],
        title: json["title"],
        ids: Ids.fromJson(json["ids"]),
        numberAbs: json["number_abs"],
        overview: json["overview"],
        rating: json["rating"].toDouble(),
        votes: json["votes"],
        commentCount: json["comment_count"],
        firstAired: DateTime.parse(json["first_aired"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        availableTranslations: new List<String>.from(
            json["available_translations"].map((x) => x)),
        runtime: json["runtime"],
      );

  Map<String, dynamic> toJson() =>
      {
        "season": season,
        "number": number,
        "title": title,
        "ids": ids.toJson(),
        "number_abs": numberAbs,
        "overview": overview,
        "rating": rating,
        "votes": votes,
        "comment_count": commentCount,
        "first_aired": firstAired.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "available_translations": new List<dynamic>.from(
            availableTranslations.map((x) => x)),
        "runtime": runtime,
      };
}
