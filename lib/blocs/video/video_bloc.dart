import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ninjanga3/repositories/movies_repository.dart';
import 'package:ninjanga3/repositories/show_repository.dart';

import './bloc.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final MoviesRepository repository;
  final ShowRepository showRepository;
  final String slug;
  final bool isMovie;

  VideoBloc({this.repository, this.showRepository, this.slug, this.isMovie});

  @override
  VideoState get initialState => RelatedUninitialized();

  @override
  Stream<VideoState> mapEventToState(
    VideoEvent event,
  ) async* {
    if (event is FetchVideoTrailerMoviesEvent) {
      yield VideoLoading();
      try {
        final videoView = isMovie ? await repository.getTrailerVideoView(
            slug: slug) : await showRepository.getTrailerVideoView(slug: slug);
        yield VideoLoaded(video: videoView);
      } catch (e) {
        print(e);
        yield VideoError(error: e);
      }
    }
  }
}
