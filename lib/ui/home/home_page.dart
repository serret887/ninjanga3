import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjanga3/blocs/home/bloc.dart';
import 'package:ninjanga3/service_locator.dart';
import 'package:ninjanga3/ui/login/alert_login.dart';

import 'home_list_view.dart';

class HomePage extends StatefulWidget {
  HomePage() {
    sl.get<HomeBloc>().dispatch(FetchHomePage());
  }
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sl.get<HomeBloc>(),
      builder: (_, HomeState state) {
        if (state is HomeLoaded) {
          return HomeListView(homePageModel: state.model);
        } else if (state is HomeError) {
          return AlertLogin(
            dispatch: () => sl.get<HomeBloc>().dispatch(FetchHomePage()),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
