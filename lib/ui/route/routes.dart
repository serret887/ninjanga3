import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'route_handlers.dart';

class Routes {
  static String root = '/';
  static String detail = '/detail/:isMovie/:slug';
  static String filter = '/filter';
  static String video = '/video/:isMovie/:slug';

  //  detail route
  static String setDetailRouter(String slug, bool isMovie) {
    final route = detail.split(':')[0];
    return '$route$isMovie/$slug';
  }

  static String getRouterSlug(Map<String, List<String>> params) {
    return params['slug'][0];
  }

  static bool getRouterIsMovie(Map<String, List<dynamic>> params) {
    return toBool(params['isMovie'][0]);
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
