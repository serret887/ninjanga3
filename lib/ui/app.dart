import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjanga3/blocs/authentication/authentication_bloc.dart';
import 'package:ninjanga3/blocs/authentication/authentication_state.dart';
import 'package:ninjanga3/ui/bottom_navigation_bar.dart';
import 'package:ninjanga3/ui/login/login_page.dart';

import '../route_navigation.dart';
import '../service_locator.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentTab = TabType.home;
  final navigatorKey = GlobalKey<NavigatorState>();

  /// keys for each tab
  final Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    TabType.home: GlobalKey<NavigatorState>(),
    TabType.browse: GlobalKey<NavigatorState>(),
    TabType.search: GlobalKey<NavigatorState>()
  };

  void _tabBarItemOnTap(int index) {
    setState(() {
      this._currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
            fontFamily: 'Vaud',
            brightness: Brightness.dark,
            primaryColor: Color(0xff26262d),
            backgroundColor: Color(0xff26262d)),
        home: BlocBuilder(
          bloc: sl.get<AuthenticationBloc>(),
          builder: (context, state) {
            return Scaffold(body: _buildGateKeeper(state));
          },
        ));
  }

  Widget _buildGateKeeper(AuthenticationState state) {
    if (state is AuthenticationAuthenticated) {
      return Scaffold(
          backgroundColor: Color(0xff26262d),
          body: Stack(
            children: <Widget>[
              _buildOffstageNavigator(TabType.home),
              _buildOffstageNavigator(TabType.browse),
              _buildOffstageNavigator(TabType.search),
            ],
          ),
          bottomNavigationBar: BottomNavigation(
            currentTab: _currentTab,
            onSelectedTab: _tabBarItemOnTap,
          ));
    } else {
      return LoginPage();
    }
  }

  Widget _buildOffstageNavigator(int tab) {
    return Offstage(
        offstage: _currentTab != tab,
        child: RouteNavigation(
          navigatorKey: navigatorKeys[tab],
          currentTab: tab,
        ));
  }
}
