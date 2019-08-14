import 'package:ninjanga3/infrastructure/tracktv/models/Common/id.dart';

class Person {
  String name;
  Ids ids;

  Person({this.name, this.ids});

  Person.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    ids = json['ids'] != null ? new Ids.fromJson(json['ids']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.ids != null) {
      data['ids'] = this.ids.toJson();
    }
    return data;
  }
}
