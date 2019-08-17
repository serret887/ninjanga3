import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ninjanga3/repositories/movies_repository.dart';

import './bloc.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc({this.repository, this.slug});

  @override
  VideoState get initialState => RelatedUninitialized();

  final MoviesRepository repository;
  final String slug;

  @override
  Stream<VideoState> mapEventToState(
    VideoEvent event,
  ) async* {
    if (event is FetchVideoTrailerMoviesEvent) {
      yield VideoLoading();
      try {
        final videoView = await repository.getVideoView(slug: slug);
        yield VideoLoaded(video: videoView);
      } catch (e) {
        print(e);
        yield VideoError(error: e);
      }
    }
  }
}
