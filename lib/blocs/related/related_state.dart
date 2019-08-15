import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ninjanga3/models/View/movie_view.dart';

@immutable
abstract class RelatedState extends Equatable {
  RelatedState([List props = const <dynamic>[]]) : super(props);
}

class RelatedUninitialized extends RelatedState {
  @override
  String toString() => 'RelatedUninitialized';
}

class RelatedLoading extends RelatedState {
  @override
  String toString() => 'RelatedLoading';
}

class RelatedLoaded extends RelatedState {
  final List<MovieView> movies;

  RelatedLoaded({this.movies}) : super([movies]);

  @override
  String toString() => 'RelatedLoaded { data: $movies }';
}

class RelatedError extends RelatedState {
  final Exception error;
  RelatedError({@required this.error});

  @override
  String toString() => 'RelatedError';
}
