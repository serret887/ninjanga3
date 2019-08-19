import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ninjanga3/models/View/poster_view.dart';

@immutable
abstract class SearchState extends Equatable {
  SearchState([List props = const <dynamic>[]]) : super(props);
}

class SearchUninitialized extends SearchState {
  @override
  String toString() => 'SearchUninitialized';
}

class SearchLoading extends SearchState {
  @override
  String toString() => 'SearchLoading';
}

class SearchLoaded extends SearchState {
  final List<PosterView> movies;

  SearchLoaded({this.movies}) : super([movies]);

  @override
  String toString() => 'SearchLoaded { data: $movies }';
}

class SearchError extends SearchState {
  final Exception error;

  SearchError({@required this.error});

  @override
  String toString() => 'SearchError';
}
