import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ninjanga3/repositories/show_repository.dart';

import './bloc.dart';

class SeasonDetailsBloc extends Bloc<SeasonDetailsEvent, SeasonDetailsState> {
  SeasonDetailsBloc({
    this.slug,
    this.showRepo,
  });

  @override
  SeasonDetailsState get initialState => SeasonDetailsStateUninitialized();
  final String slug;
  final ShowRepository showRepo;

  @override
  Stream<SeasonDetailsState> mapEventToState(
    SeasonDetailsEvent event,
  ) async* {
    if (event is SeasonDetailsFetchEvent) {
      yield SeasonDetailsStateLoading();

      try {
        final show =
            await showRepo.getShowDetails(number: event.number, slug: slug);
        final seasonView = show.getSeasonView(number: event.number);
        yield SeasonDetailsSummaryStateLoaded(data: seasonView);
      } catch (e) {
        print(e);
        yield SeasonDetailsStateError(error: e);
      }
    }
  }
}
