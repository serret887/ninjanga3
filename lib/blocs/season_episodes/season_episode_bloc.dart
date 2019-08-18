import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ninjanga3/repositories/show_repository.dart';

import './bloc.dart';

class SeasonEpisodeBloc extends Bloc<SeasonEpisodeEvent, SeasonEpisodeState> {
  SeasonEpisodeBloc({this.repository, this.slug});

  @override
  SeasonEpisodeState get initialState => SeasonEpisodeUninitialized();

  final ShowRepository repository;
  final String slug;

  @override
  Stream<SeasonEpisodeState> mapEventToState(
    SeasonEpisodeEvent event,
  ) async* {
    if (event is FetchSeasonEpisodesEvent) {
      yield SeasonEpisodesLoading();
      try {
        final episodesDb = await repository.getShowEpisodeDetails(
            slug: slug, seasonNumber: event.seasonNumber);
        final show = await repository.getShowDetails(
            slug: slug, number: event.seasonNumber);
        final episodes = episodesDb
            .map((e) => e.getEpisodePosterView(show.posterImage))
            .toList();
        yield SeasonEpisodeLoaded(episodes: episodes);
      } catch (e) {
        print(e);
        yield SeasonEpisodeError(error: e);
      }
    }
  }
}
