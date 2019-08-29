import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ninjanga3/repositories/search_repository.dart';

import './bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.repository);

  @override
  SearchState get initialState => SearchUninitialized();

  final SearchRepository repository;

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is FetchSearchEvent) {
      yield SearchLoading();
      try {
        var posters = await repository.search(event.query);
        if (posters.length == 0)
          yield SearchError(
              error: Exception("Empty list of results, try another title"));
        else
          yield SearchLoaded(movies: posters);
      } catch (e) {
        print(e);
        yield SearchError(error: e);
      }
    }
  }
}
