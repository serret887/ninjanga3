import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ninjanga3/ui/route/routes.dart';

import '../../service_locator.dart';

class RouteCommands {
  static goToVideoPlayer(
          {@required BuildContext context,
          @required String slug,
          @required bool isMovie}) =>
      sl.get<Router>().navigateTo(
            context,
            Routes.setVideoRouter(slug, isMovie),
            transition: TransitionType.cupertino,
            transitionDuration: const Duration(milliseconds: 1000),
          );
}
