import 'package:json_annotation/json_annotation.dart';

import 'cast.dart';
import 'crew.dart';
part 'credits.g.dart';

@JsonSerializable()
class Credits {
  List<Cast> cast;
  Crew crew;

  Credits({this.cast, this.crew});

  Credits.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      cast = new List<Cast>();
      json['cast'].forEach((v) {
        cast.add(new Cast.fromJson(v));
      });
    }
    crew = json['crew'] != null ? new Crew.fromJson(json['crew']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cast != null) {
      data['cast'] = this.cast.map((v) => v.toJson()).toList();
    }
    if (this.crew != null) {
      data['crew'] = this.crew.toJson();
    }
    return data;
  }
}
