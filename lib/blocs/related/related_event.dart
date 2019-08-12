import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RelatedEvent extends Equatable {
  RelatedEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchRelatedMoviesEvent extends RelatedEvent {
  @override
  String toString() => 'FetchRelatedMoviesEvent';
}
