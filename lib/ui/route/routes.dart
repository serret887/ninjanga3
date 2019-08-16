import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'route_handlers.dart';

class Routes {
  static String root = '/';
  static String summary = '/summary';
  static String detail = '/detail/:isMovie/:slug';
  static String filter = '/filter';
  static String video = '/video/:title:url';

  //  detail route
  static String setDetailRouter(String slug, bool isMovie) {
    final route = detail.split(':')[0];
    return '$route$isMovie/$slug';
  }

  static String getDetailRouterSlug(Map<String, List<String>> params) {
    return params['slug'][0];
  }

  static bool getDetailRouterIsMovie(Map<String, List<dynamic>> params) {
    return toBool(params['isMovie'][0]);
  }

  //  end detail route

  //  video route
  static String setVideoRouter(String title, String url) {
    final route = video.split(':')[0];
    return '$route$title/$url';
  }

  static String getVideoRouterTitle(Map<String, List<String>> params) {
    return params['title'][0];
  }

  static String getVideoRouterUrl(Map<String, List<dynamic>> params) {
    return params['url'][0];
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
    router.define(summary, handler: summaryRouteHandler);
    router.define(detail, handler: detailRouteHandler);
    router.define(filter, handler: filterRouteHandler);
    router.define(video, handler: trailerRouteHandler);
  }
}
