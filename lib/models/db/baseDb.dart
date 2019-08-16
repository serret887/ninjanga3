import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Common/id.dart';

import 'package:json_annotation/json_annotation.dart';

part 'baseDb.g.dart';

@JsonSerializable()
class BaseDb {
  final String title;
  final int year;
  final Ids ids;

  BaseDb(this.title, this.year, this.ids);
}
