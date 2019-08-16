import 'package:json_annotation/json_annotation.dart';
part 'directing.g.dart';

@JsonSerializable()
class Directing {
  List<String> jobs;

  Directing({
    this.jobs,
  });

  Directing.fromJson(Map<String, dynamic> json) {
    jobs = json['jobs']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobs'] = this.jobs;
    return data;
  }
}
