import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ninjanga3/models/View/featured_view.dart';
import 'package:ninjanga3/models/View/poster_view.dart';
import 'package:ninjanga3/models/home_page_model.dart';
import 'package:ninjanga3/repositories/movies_repository.dart';
import 'package:ninjanga3/repositories/show_repository.dart';

import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MoviesRepository movieRepo;
  final ShowRepository showRepo;

  HomeBloc(this.movieRepo, this.showRepo);

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchHomePage) {
      yield HomeLoading();
      try {
        await Future.wait(
            [movieRepo.fetchHomeData(), showRepo.fetchHomeData()]);

        var featuredMovies = await movieRepo.getFeaturedViews();
        var postersMovies = await movieRepo.getAllPosters();
        var featuredShows = await showRepo.getFeaturedViews();
        var postersShows = await showRepo.getAllPosters();

        var posters = List<PosterView>();
        if (postersMovies != null) posters.addAll(postersMovies);
        if (postersShows != null) posters.addAll(postersShows);

        var featured = List<FeaturedView>();
        if (featuredMovies != null) featured.addAll(featuredMovies);
        if (featuredShows != null) featured.addAll(featuredShows);

        HomePageModel home =
            HomePageModel(featuredMovies: featured, movies: posters);

        yield HomeLoaded(model: home);
      } catch (e) {
        print(e);
        yield HomeError(error: e);
      }
    }
  }
}
