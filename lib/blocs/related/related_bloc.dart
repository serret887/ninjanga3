import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ninjanga3/repositories/movies_repository.dart';
import 'package:ninjanga3/repositories/show_repository.dart';

import './bloc.dart';

class RelatedBloc extends Bloc<RelatedEvent, RelatedState> {
  RelatedBloc(this.id, [this.repository, this.showRepository]);

  @override
  RelatedState get initialState => RelatedUninitialized();

  MoviesRepository repository;
  ShowRepository showRepository;
  final String id;

  @override
  Stream<RelatedState> mapEventToState(
    RelatedEvent event,
  ) async* {
    if (event is FetchRelatedEvent) {
      yield RelatedLoading();
      try {
        if (event.inMovie == true) {
          final movies = await repository.getRelatedMovies(slug: id);
          yield RelatedLoaded(movies: movies);
        } else {
          final movies = await showRepository.getRelatedShows(slug: id);
          yield RelatedLoaded(movies: movies);
        }
      } catch (e) {
        print(e);
        yield RelatedError(error: e);
      }
    }
  }
}
