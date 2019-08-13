import 'package:bloc/bloc.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ninjanga3/blocs/authentication/authentication_bloc.dart';
import 'package:ninjanga3/blocs/authentication/authentication_event.dart';
import 'package:ninjanga3/service_locator.dart';

import 'ui/app.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  setup();
  sl.get<AuthenticationBloc>().dispatch(AppStarted());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: sl
            .get<Router>()
            .generator,
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
            fontFamily: 'Vaud',
            brightness: Brightness.dark,
            primaryColor: Colors.red, //(0xff26262d),
            backgroundColor: Colors.black),
        home: App());
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('Transition: $transition');
  }
}
