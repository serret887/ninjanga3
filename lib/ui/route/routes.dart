import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'route_handlers.dart';

class Routes {
  static String root = '/';
  static String detail = '/detail/:isMovie/:slug/:season';
  static String filter = '/filter';
  static String video = '/video/:isMovie/:slug';

  //  detail route
  static String setDetailRouter(String slug, bool isMovie, [int season = 1]) {
    final route = detail.split(':')[0];
    String result = isMovie == true
        ? '$route$isMovie/$slug/'
        : '$route$isMovie/$slug/$season';
    return result;
  }

  static String getRouterSlug(Map<String, List<String>> params) {
    return params['slug'][0];
  }

  static bool getRouterIsMovie(Map<String, List<dynamic>> params) {
    return toBool(params['isMovie'][0]);
  }

  static int getRouterSeason(Map<String, List<dynamic>> params) {
    return int.parse(params['season'][0]);
  }

  //  end detail route

  //  video route
  static String setVideoRouter(String slug, bool isMovie) {
    final route = video.split(':')[0];
    return '$route$isMovie/$slug';
  }

  //  end video  route

  static bool toBool(String val) => val.toLowerCase() == 'true';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(handlerFunc: (
      BuildContext context,
      Map<String, List<String>> params,
    ) {
      print('ROUTE WAS NOT FOUND !!!');
      return Container(
        child: Text("Route not found"),
      );
    });
    router.define(root, handler: rootHandler);
    router.define(detail, handler: detailRouteHandler);
    router.define(filter, handler: filterRouteHandler);
    router.define(video, handler: trailerRouteHandler);
  }
}
