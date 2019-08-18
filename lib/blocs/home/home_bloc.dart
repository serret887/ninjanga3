import 'dart:async';

import 'package:bloc/bloc.dart';
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
        final HomePageModel homemoviePageModel =
            await movieRepo.getHomePageModel();
        final HomePageModel homePageModel = await showRepo.getHomePageModel();
        homePageModel.addFeaturedViews(homemoviePageModel.getFeatured());
        homePageModel
            .addPosterViews(homemoviePageModel.getAllPostersByOrigin());
        yield HomeLoaded(model: homePageModel);
      } catch (e) {
        print(e);
        yield HomeError(error: e);
      }
    }
  }
}
