import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RelatedEvent extends Equatable {
  RelatedEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchRelatedEvent extends RelatedEvent {
  final bool inMovie;

  FetchRelatedEvent(this.inMovie);
  @override
  String toString() => 'FetchRelatedMoviesEvent';
}
