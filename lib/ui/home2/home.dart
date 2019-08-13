import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjanga3/blocs/home/bloc.dart';
import 'package:ninjanga3/ui/components/alert_dispatcher.dart';
import 'package:ninjanga3/ui/home2/home_list_view.dart';

import '../../service_locator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sl.get<HomeBloc>(),
      builder: (_, HomeState state) {
        if (state is HomeLoaded) {
          return HomeListView(homePageModel: state.model);
        } else if (state is HomeError) {
          return AlertDispather(
            dispatch: () => sl.get<HomeBloc>().dispatch(FetchHomePage()),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
