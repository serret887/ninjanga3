import 'package:ninjanga3/infrastructure/tracktv/models/Common/id.dart';

class SeasonSummaryTracktv {
  String title;
  int year;
  Ids ids;
  String overview;
  DateTime firstAired;
  Airs airs;
  int runtime;
  String certification;
  String network;
  String country;
  String trailer;
  String homepage;
  String status;
  double rating;
  int votes;
  int commentCount;
  DateTime updatedAt;
  String language;
  List<String> availableTranslations;
  List<String> genres;
  int airedEpisodes;

  SeasonSummaryTracktv({
    this.title,
    this.year,
    this.ids,
    this.overview,
    this.firstAired,
    this.airs,
    this.runtime,
    this.certification,
    this.network,
    this.country,
    this.trailer,
    this.homepage,
    this.status,
    this.rating,
    this.votes,
    this.commentCount,
    this.updatedAt,
    this.language,
    this.availableTranslations,
    this.genres,
    this.airedEpisodes,
  });

  factory SeasonSummaryTracktv.fromJson(Map<String, dynamic> json) =>
      new SeasonSummaryTracktv(
        title: json["title"],
        year: json["year"],
        ids: Ids.fromJson(json["ids"]),
        overview: json["overview"],
        firstAired: DateTime.parse(json["first_aired"]),
        airs: Airs.fromJson(json["airs"]),
        runtime: json["runtime"],
        certification: json["certification"],
        network: json["network"],
        country: json["country"],
        trailer: json["trailer"],
        homepage: json["homepage"],
        status: json["status"],
        rating: json["rating"].toDouble(),
        votes: json["votes"],
        commentCount: json["comment_count"],
        updatedAt: DateTime.parse(json["updated_at"]),
        language: json["language"],
        availableTranslations:
            new List<String>.from(json["available_translations"].map((x) => x)),
        genres: new List<String>.from(json["genres"].map((x) => x)),
        airedEpisodes: json["aired_episodes"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "year": year,
        "ids": ids.toJson(),
        "overview": overview,
        "first_aired": firstAired.toIso8601String(),
        "airs": airs.toJson(),
        "runtime": runtime,
        "certification": certification,
        "network": network,
        "country": country,
        "trailer": trailer,
        "homepage": homepage,
        "status": status,
        "rating": rating,
        "votes": votes,
        "comment_count": commentCount,
        "updated_at": updatedAt.toIso8601String(),
        "language": language,
        "available_translations":
            new List<dynamic>.from(availableTranslations.map((x) => x)),
        "genres": new List<dynamic>.from(genres.map((x) => x)),
        "aired_episodes": airedEpisodes,
      };
}

class Airs {
  String day;
  String time;
  String timezone;

  Airs({
    this.day,
    this.time,
    this.timezone,
  });

  factory Airs.fromJson(Map<String, dynamic> json) => new Airs(
        day: json["day"],
        time: json["time"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "time": time,
        "timezone": timezone,
      };
}
