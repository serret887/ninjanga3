import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ninjanga3/models/View/detail_description_view.dart';

@immutable
abstract class MovieDetailsState extends Equatable {
  MovieDetailsState([List props = const <dynamic>[]]) : super(props);
}

class MovieDetailsStateUninitialized extends MovieDetailsState {
  @override
  String toString() => 'MovieDetailsStateUninitialized';
}

class MovieDetailsStateLoading extends MovieDetailsState {
  @override
  String toString() => 'MovieDetailsStateLoading';
}

class MovieDetailsStateLoaded extends MovieDetailsState {
  final DetailDescriptionView data;
  MovieDetailsStateLoaded({@required this.data});

  @override
  String toString() => 'MovieDetailsStateLoaded';
}

class MovieDetailsStateError extends MovieDetailsState {
  final Error error;
  MovieDetailsStateError({@required this.error});

  @override
  String toString() => 'RelatedError';
}
