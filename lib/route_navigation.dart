import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ninjanga3/ui/home/home_page.dart';

import 'ui/category_page/category_page.dart';
import 'ui/movie_page/movie_details_page.dart';

class TabType {
  static const home = 0;
  static const browse = 1;
  static const search = 2;
}

class TabNavigatorRoutes {
  static const String root = '/';
  static const String movieCategory = 'movieCategory';
}

class RouteNavigation extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final int currentTab;

  RouteNavigation({
    Key key,
    @required this.navigatorKey,
    @required this.currentTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        initialRoute: TabNavigatorRoutes.root,
        onGenerateRoute: (routeSettings) {
          return _routeForRouteSettings(routeSettings: routeSettings);
        });
  }

  PageRoute _routeForRouteSettings({@required RouteSettings routeSettings}) {
    return MaterialPageRoute(builder: (context) {
      if (routeSettings.name == TabNavigatorRoutes.root) {
        switch (currentTab) {
          case TabType.home:
            return HomePage();
//          case TabType.browse:
//            return BrowsePage();
//          case TabType.search:
//            return SearchPage();
          default:
            break;
        }
      }
      if (routeSettings.name == MovieDetailsPageArguments.routeName) {
        final MovieDetailsPageArguments args = routeSettings.arguments;
        return MovieDetailsPage(movie: args.movie);
      }
      if (routeSettings.name == TabNavigatorRoutes.movieCategory) {
        final MovieCategoryPageArguments args = routeSettings.arguments;
        return MovieCategoryPage(movies: args.movies, title: args.title);
      }
      return Container(
        child: Center(
          child: Text("There was a route error contact support"),
        ),
      );
    });
  }
}
