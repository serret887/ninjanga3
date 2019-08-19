import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchEvent extends Equatable {
  SearchEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchSearchEvent extends SearchEvent {
  final String query;

  FetchSearchEvent(this.query);

  @override
  String toString() => 'FetchSearchMoviesEvent $query';
}
