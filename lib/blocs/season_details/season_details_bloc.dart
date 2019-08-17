import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ninjanga3/models/View/seasonView.dart';
import 'package:ninjanga3/repositories/season_repository.dart';
import 'package:ninjanga3/repositories/show_repository.dart';

import './bloc.dart';

class SeasonDetailsBloc extends Bloc<SeasonDetailsEvent, SeasonDetailsState> {
  SeasonDetailsBloc({this.slug, this.showRepo, this.seasonRepo});


  @override
  SeasonDetailsState get initialState => SeasonDetailsStateUninitialized();
  final String slug;
  final ShowRepository showRepo;
  final SeasonRepository seasonRepo;

  @override
  Stream<SeasonDetailsState> mapEventToState(
    SeasonDetailsEvent event,
  ) async* {
    if (event is SeasonDetailsFetchEvent) {
      yield SeasonDetailsStateLoading();

      try {
        final show = await showRepo.getShowDetails(slug);
        final season = await seasonRepo.getSeasonDetails(slug, event.number);
        final seasonView = SeasonView.fromDb(show, season);
        yield SeasonDetailsStateLoaded(data: seasonView);
      } catch (e) {
        print(e);
        yield SeasonDetailsStateError(error: e);
      }
    }
  }
}
