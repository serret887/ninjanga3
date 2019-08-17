import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjanga3/blocs/video/bloc.dart';
import 'package:ninjanga3/repositories/movies_repository.dart';
import 'package:ninjanga3/ui/components/alert_dispatcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../service_locator.dart';
import 'player_control.dart';
import 'player_lifecycle.dart';

class Video extends StatefulWidget {
  final String slug;
  final bool isMovie;

  const Video({Key key, this.slug, this.isMovie}) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  VideoPlayerController vcontroller;
  bool controlVisible;
  Timer timer;
  String trailerUrl;
  String title;
  VideoBloc _videoBloc;

  @override
  initState() {
    var repo = sl.get<MoviesRepository>();
    _videoBloc = VideoBloc(repository: repo, slug: widget.slug);
    _videoBloc.dispatch(FetchVideoTrailerMoviesEvent());
    controlVisible = true;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
    autoHide();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    vcontroller?.dispose();
    timer?.cancel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  void handlerGesture() {
    setState(() {
      controlVisible = !controlVisible;
    });
    autoHide();
  }

  void autoHide() {
    if (controlVisible) {
      timer = Timer(
          Duration(seconds: 5), () => setState(() => controlVisible = false));
    } else {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = 0.75;
    return BlocBuilder(
        bloc: _videoBloc,
        builder: (_, VideoState state) {
          if (state is VideoLoaded) {
            if (state.video.url.contains("youtube")) {
              var videoId = YoutubePlayer.convertUrlToId(state.video.url)
                  ?? state.video.url.split("=")[1];
              return Scaffold(
                  backgroundColor: Colors.black,
                  body: YoutubePlayer(
                    context: context,
                    inFullScreen: true,
                    videoId: videoId,
                    flags: YoutubePlayerFlags(
                      autoPlay: true,

                      showVideoProgressIndicator: true,
                    ),
                  ));
            } else {
              vcontroller = VideoPlayerController.network(state.video.url);
              return Scaffold(
                backgroundColor: Colors.black,
                body: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    PlayerLifeCycle(
                      controller: vcontroller,
                      childBuilder: (BuildContext context,
                          VideoPlayerController controller) =>
                          AspectRatio(
                            aspectRatio: aspectRatio,
                            child: VideoPlayer(vcontroller),
                          ),
                    ),
                    GestureDetector(
                      child: PlayerControl(
                        controller: vcontroller,
                        visible: controlVisible,
                        title: state.video.title,
                      ),
                      onTap: handlerGesture,
                    ),
                  ],
                ),
              );
            }
          } else if (state is VideoError) {
            return AlertDispather(
              dispatch: () =>
                  _videoBloc.dispatch(FetchVideoTrailerMoviesEvent()),
            );
          }

          return Center(child: CircularProgressIndicator());
        });
  }
}
