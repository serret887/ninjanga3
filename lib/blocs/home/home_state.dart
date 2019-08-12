import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ninjanga3/models/home_page_model.dart';

@immutable
abstract class HomeState extends Equatable {
  HomeState([List props = const <dynamic>[]]) : super(props);
}

class InitialHomeState extends HomeState {}

class HomeLoading extends HomeState {
  @override
  String toString() => 'HomeLoading';
}

class HomeLoaded extends HomeState {
  final HomePageModel model;

  HomeLoaded({this.model}) : super([model]);

  @override
  String toString() => 'HomeLoaded { data: $model }';
}

class HomeError extends HomeState {
  final Error error;
  HomeError({@required this.error});

  @override
  String toString() => 'HomeError';
}
