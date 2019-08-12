import 'id.dart';

class Show {
  String title;
  int year;
  Ids ids;

  Show({this.title, this.year, this.ids});

  Show.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    year = json['year'];
    ids = json['ids'] != null ? new Ids.fromJson(json['ids']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['year'] = this.year;
    if (this.ids != null) {
      data['ids'] = this.ids.toJson();
    }
    return data;
  }
}
