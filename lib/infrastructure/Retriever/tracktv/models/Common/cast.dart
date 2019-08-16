import 'package:json_annotation/json_annotation.dart';
part 'cast.g.dart';

@JsonSerializable()
class Cast {
  List<String> characters;

  Cast({
    this.characters,
  });

  Cast.fromJson(Map<String, dynamic> json) {
    characters = json['characters']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['characters'] = this.characters;
    return data;
  }
}
