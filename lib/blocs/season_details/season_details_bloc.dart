import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ninjanga3/repositories/series_repository.dart';

import './bloc.dart';

class SeasonDetailsBloc extends Bloc<SeasonDetailsEvent, SeasonDetailsState> {
  SeasonDetailsBloc(this.slug, this.repo);

  @override
  SeasonDetailsState get initialState => SeasonDetailsStateUninitialized();
  final String slug;
  final SeriesRepository repo;

  @override
  Stream<SeasonDetailsState> mapEventToState(
    SeasonDetailsEvent event,
  ) async* {
    if (event is SeasonDetailsEventFetch) {
      yield SeasonDetailsStateLoading();

      try {
        final Season = await repo.getSeasonDetails(slug);
        yield SeasonDetailsStateLoaded(data: Season);
      } catch (e) {
        print(e);
        yield SeasonDetailsStateError(error: e);
      }
    }
  }
}
