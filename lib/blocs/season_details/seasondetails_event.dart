import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SeasonDetailsEvent extends Equatable {
  SeasonDetailsEvent([List props = const <dynamic>[]]) : super(props);
}

class SeasonDetailsEventFetch extends SeasonDetailsEvent {
  @override
  String toString() => 'MovieDetailsEventFetch';
}
