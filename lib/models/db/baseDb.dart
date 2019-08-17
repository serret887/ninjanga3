import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/Common/id.dart';

//part 'baseDb.g.dart';

//@JsonSerializable()
abstract class BaseDb {
  final String title;
  final int year;
  final Ids ids;

  BaseDb(this.title, this.year, this.ids);

  Map<String, dynamic> toJson();
}
