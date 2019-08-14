import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'route_handlers.dart';

class Routes {
  static String root = '/';
  static String summary = '/summary';
  static String detail = '/detail/:isMovie/:slug';
  static String filter = '/filter';
  static String video = '/trailer';

  static String setDetailRouter(String slug, bool isMovie) {
    final route = detail.split(':')[0];
    return '$route$isMovie/$slug';
  }

  static String getDetailRouterSlug(Map<String, List<String>> params) {
    return params['slug'][0];
  }

  static bool getDetailRouterIsMovie(Map<String, List<dynamic>> params) {
    return params['isMovie'][0];
  }

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
    router.define(summary, handler: summaryRouteHandler);
    router.define(detail, handler: detailRouteHandler);
    router.define(filter, handler: filterRouteHandler);
    router.define(video, handler: trailerRouteHandler);
  }
}
