import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjanga3/blocs/authentication/authentication_bloc.dart';
import 'package:ninjanga3/blocs/authentication/authentication_state.dart';
import 'package:ninjanga3/ui/login/login_page.dart';

import '../service_locator.dart';
import 'home/home_page.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
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
      return HomePage();
    } else {
      return LoginPage();
    }
  }
}
