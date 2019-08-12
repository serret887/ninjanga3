import 'id.dart';

class Season {
  int number;
  Ids ids;

  Season({this.number, this.ids});

  Season.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    ids = json['ids'] != null ? new Ids.fromJson(json['ids']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.number;
    if (this.ids != null) {
      data['ids'] = this.ids.toJson();
    }
    return data;
  }
}
