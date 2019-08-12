import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchHomePage extends HomeEvent {
  @override
  String toString() => 'FetchHomePage';
}
