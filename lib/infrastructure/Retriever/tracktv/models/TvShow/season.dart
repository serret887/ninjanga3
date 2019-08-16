import '../Common/id.dart';
import '../TvShow/episode.dart';

class Season {
  int number;
  Ids ids;
  List<Episode> episodes;

  Season({
    this.number,
    this.ids,
    this.episodes,
  });

  factory Season.fromJson(Map<String, dynamic> json) => new Season(
        number: json["number"],
        ids: Ids.fromJson(json["ids"]),
        episodes: new List<Episode>.from(
            json["episodes"].map((x) => Episode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "ids": ids.toJson(),
        "episodes": new List<dynamic>.from(episodes.map((x) => x.toJson())),
      };
}
