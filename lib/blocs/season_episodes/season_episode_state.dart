import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ninjanga3/models/View/episode_poster_view.dart';
import 'package:ninjanga3/models/View/poster_view.dart';

@immutable
abstract class SeasonEpisodeState extends Equatable {
  SeasonEpisodeState([List props = const <dynamic>[]]) : super(props);
}

class SeasonEpisodeUninitialized extends SeasonEpisodeState {
  @override
  String toString() => 'SeasonEpisodeUninitialized';
}

class SeasonEpisodesLoading extends SeasonEpisodeState {
  @override
  String toString() => 'SeasonEpisodeLoading';
}

class SeasonEpisodeLoaded extends SeasonEpisodeState {
  final List<EpisodePosterView> episodes;

  SeasonEpisodeLoaded({this.episodes}) : super([episodes]);

  @override
  String toString() => 'SeasonEpisodeLoaded { data: $episodes }';
}

class SeasonEpisodeError extends SeasonEpisodeState {
  final Exception error;
  SeasonEpisodeError({@required this.error});

  @override
  String toString() => 'SeasonEpisodeError';
}
