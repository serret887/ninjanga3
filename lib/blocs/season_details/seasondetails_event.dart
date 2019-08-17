import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SeasonDetailsEvent extends Equatable {
  SeasonDetailsEvent([List props = const <dynamic>[]]) : super(props);
}

class SeasonDetailsFetchEvent extends SeasonDetailsEvent {
  final int number;

  SeasonDetailsFetchEvent({this.number});
  @override
  String toString() => 'SeasonDetailsFetchEvent ';
}
