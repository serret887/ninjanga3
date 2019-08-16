import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

typedef Widget VideoWidgetBuilder(
    BuildContext context, VideoPlayerController controller);

class PlayerLifeCycle extends StatefulWidget {
  final VideoPlayerController controller;
  final VideoWidgetBuilder childBuilder;

  const PlayerLifeCycle({Key key, this.controller, this.childBuilder})
      : super(key: key);

  @override
  _PlayerLifeCycleState createState() => _PlayerLifeCycleState();
}

class _PlayerLifeCycleState extends State<PlayerLifeCycle> {
  VideoPlayerController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.value.hasError) {
        print(controller.value.errorDescription);
      }
    });
    controller.initialize();
    controller.setLooping(false);
    controller.play();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return widget.childBuilder(context, controller);
  }
}
