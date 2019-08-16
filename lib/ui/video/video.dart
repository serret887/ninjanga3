import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'player_control.dart';
import 'player_lifecycle.dart';

class Video extends StatefulWidget {
  final String title;
  final String url;

  const Video({Key key, this.title, this.url}) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  VideoPlayerController vcontroller;
  bool controlVisible;
  Timer timer;

  @override
  void initState() {
    controlVisible = true;
    vcontroller = VideoPlayerController.network(widget.url);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
    autoHide();
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PlayerLifeCycle(
            controller: vcontroller,
            childBuilder:
                (BuildContext context, VideoPlayerController controller) =>
                    AspectRatio(
              aspectRatio: aspectRatio,
              child: VideoPlayer(vcontroller),
            ),
          ),
          GestureDetector(
            child: PlayerControl(
              controller: vcontroller,
              visible: controlVisible,
              title: widget.title,
            ),
            onTap: handlerGesture,
          ),
        ],
      ),
    );
  }
}
