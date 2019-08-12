import 'id.dart';

class Episode {
  int season;
  int number;
  String title;
  Ids ids;

  Episode({this.season, this.number, this.title, this.ids});

  Episode.fromJson(Map<String, dynamic> json) {
    season = json['season'];
    number = json['number'];
    title = json['title'];
    ids = json['ids'] != null ? new Ids.fromJson(json['ids']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['season'] = this.season;
    data['number'] = this.number;
    data['title'] = this.title;
    if (this.ids != null) {
      data['ids'] = this.ids.toJson();
    }
    return data;
  }
}
