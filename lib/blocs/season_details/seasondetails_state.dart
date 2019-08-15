import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ninjanga3/models/View/seasonView.dart';

@immutable
abstract class SeasonDetailsState extends Equatable {
  SeasonDetailsState([List props = const <dynamic>[]]) : super(props);
}

class SeasonDetailsStateUninitialized extends SeasonDetailsState {
  @override
  String toString() => 'SeasonDetailsStateUninitialized';
}

class SeasonDetailsStateLoading extends SeasonDetailsState {
  @override
  String toString() => 'SeasonDetailsStateLoading';
}

class SeasonDetailsStateLoaded extends SeasonDetailsState {
  final SeasonView data;
  SeasonDetailsStateLoaded({@required this.data});

  @override
  String toString() => 'SeasonDetailsStateLoaded';
}

class SeasonDetailsStateError extends SeasonDetailsState {
  final Error error;
  SeasonDetailsStateError({@required this.error});

  @override
  String toString() => 'RelatedError';
}
