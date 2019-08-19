import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Common/skinny_show.dart';

class SearchResults {
  String type;
  double score;
  SkinnyShow movie;
  SkinnyShow show;

  SearchResults({
    this.type,
    this.score,
    this.movie,
    this.show,
  });

  factory SearchResults.fromJson(Map<String, dynamic> json) =>
      new SearchResults(
        type: json["type"],
        score: json["score"].toDouble(),
        movie:
            json["movie"] == null ? null : SkinnyShow.fromJson(json["movie"]),
        show: json["show"] == null ? null : SkinnyShow.fromJson(json["show"]),
      );
}
