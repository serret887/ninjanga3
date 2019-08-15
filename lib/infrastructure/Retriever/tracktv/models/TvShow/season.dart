import '../Common/id.dart';
import '../TvShow/episode.dart';

class SeasonTracktv {

  int number;
  Ids ids;
  List<Episode> episodes;

  SeasonTracktv({
    this.number,
    this.ids,
    this.episodes,
  });

  factory SeasonTracktv.fromJson(Map<String, dynamic> json) =>
      new SeasonTracktv(
        number: json["number"],
        ids: Ids.fromJson(json["ids"]),
        episodes: new List<Episode>.from(
            json["episodes"].map((x) => Episode.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "number": number,
        "ids": ids.toJson(),
        "episodes": new List<dynamic>.from(episodes.map((x) => x.toJson())),
      };
}
