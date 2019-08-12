import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ninjanga3/repositories/movies_repository.dart';
import './bloc.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc(this.slug, this.repo);

  @override
  MovieDetailsState get initialState => MovieDetailsStateUninitialized();
  final String slug;
  final MoviesRepository repo;

  @override
  Stream<MovieDetailsState> mapEventToState(
    MovieDetailsEvent event,
  ) async* {
    if (event is MovieDetailsStateLoading) {
      yield MovieDetailsStateLoading();

      try {
        final movie = await repo.getMovieDetails(slug);
        yield MovieDetailsStateLoaded(data: movie);
      } catch (e) {
        print(e);
        yield MovieDetailsStateError(error: e);
      }
    }
  }
}
