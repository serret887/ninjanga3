import 'package:json_annotation/json_annotation.dart';

import 'directing.dart';
part 'crew.g.dart';

@JsonSerializable()
class Crew {
  List<Directing> directing;

  Crew({this.directing});

  Crew.fromJson(Map<String, dynamic> json) {
    if (json['directing'] != null) {
      directing = new List<Directing>();
      json['directing'].forEach((v) {
        directing.add(new Directing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.directing != null) {
      data['directing'] = this.directing.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
