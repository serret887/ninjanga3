import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjanga3/blocs/authentication/authentication_bloc.dart';
import 'package:ninjanga3/blocs/authentication/authentication_state.dart';
import 'package:ninjanga3/blocs/home/bloc.dart';
import 'package:ninjanga3/ui/login/login_page.dart';

import '../service_locator.dart';
import 'home/home.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  final navigatorKey = GlobalKey<NavigatorState>();
  TabController controller;

  @override
  void initState() {
    sl.get<HomeBloc>().dispatch(FetchHomePage());
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    controller = TabController(length: 3, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sl.get<AuthenticationBloc>(),
      builder: (context, state) {
        return _buildGateKeeper(state);
      },
    );
  }

  Widget _buildGateKeeper(AuthenticationState state) {
    if (state is AuthenticationAuthenticated) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        bottomNavigationBar: TabBar(
          labelStyle: TextStyle(fontSize: 10.0),
          indicatorWeight: 0.1,
          controller: controller,
          tabs: <Widget>[
            Tab(text: 'Inicio', icon: Icon(Icons.home)),
            Tab(text: 'Buscar', icon: Icon(Icons.search)),
            Tab(text: 'Descargas', icon: Icon(Icons.file_download)),
          ],
        ),
        body: TabBarView(
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Home(),
            Home(),
            Home(),
          ],
        ),
      );
    } else {
      return LoginPage();
    }
  }
}
