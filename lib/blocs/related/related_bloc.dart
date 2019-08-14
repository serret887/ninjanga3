import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ninjanga3/repositories/movies_repository.dart';

import './bloc.dart';

class RelatedBloc extends Bloc<RelatedEvent, RelatedState> {
  RelatedBloc(this.repository, this.id);

  @override
  RelatedState get initialState => RelatedUninitialized();

  final MoviesRepository repository;
  final String id;

  @override
  Stream<RelatedState> mapEventToState(
    RelatedEvent event,
  ) async* {
    if (event is FetchRelatedMoviesEvent) {
      yield RelatedLoading();

      try {
        final movies = await repository.getRelatedMovies(slug: id);
        yield RelatedLoaded(movies: movies);
      } catch (e) {
        print(e);
        yield RelatedError(error: e);
      }
    }
  }
}
