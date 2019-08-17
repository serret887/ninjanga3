import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VideoEvent extends Equatable {
  VideoEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchVideoTrailerMoviesEvent extends VideoEvent {
  @override
  String toString() => 'FetchVideoTrailer';
}
