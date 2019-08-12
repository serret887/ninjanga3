import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MovieDetailsEvent extends Equatable {
  MovieDetailsEvent([List props = const <dynamic>[]]) : super(props);
}

class MovieDetailsEventFetch extends MovieDetailsEvent {
  @override
  String toString() => 'MovieDetailsEventFetch';
}
