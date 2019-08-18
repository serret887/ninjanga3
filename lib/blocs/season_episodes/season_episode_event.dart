import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SeasonEpisodeEvent extends Equatable {
  SeasonEpisodeEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchSeasonEpisodesEvent extends SeasonEpisodeEvent {
  final int seasonNumber;

  FetchSeasonEpisodesEvent(this.seasonNumber);
  @override
  String toString() => 'FetchSeasonEpisodeMoviesEvent';
}
