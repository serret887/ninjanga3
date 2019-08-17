import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ninjanga3/models/View/video_view.dart';

@immutable
abstract class VideoState extends Equatable {
  VideoState([List props = const <dynamic>[]]) : super(props);
}

class RelatedUninitialized extends VideoState {
  @override
  String toString() => 'VideoUninitialized';
}

class VideoLoading extends VideoState {
  @override
  String toString() => 'VideoLoading';
}

class VideoLoaded extends VideoState {
  final VideoView video;

  VideoLoaded({this.video}) : super([video]);

  @override
  String toString() => 'VideoLoaded { data: $video }';
}

class VideoError extends VideoState {
  final Exception error;

  VideoError({@required this.error});

  @override
  String toString() => 'VideoError';
}
