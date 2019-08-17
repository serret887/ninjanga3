import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjanga3/blocs/season_details/bloc.dart';
import 'package:ninjanga3/repositories/season_repository.dart';
import 'package:ninjanga3/repositories/show_repository.dart';

import '../../service_locator.dart';
import 'tv_show_details_app_bar.dart';

class TvShowDetails extends StatefulWidget {
  final String slug;

  const TvShowDetails({
    Key key,
    this.slug,
  }) : super(key: key);

  @override
  _TvShowDetailsState createState() => _TvShowDetailsState();
}

class _TvShowDetailsState extends State<TvShowDetails> {
  String get slug => widget.slug;
  SeasonDetailsBloc _seasonDetailsBloc;
  @override
  void initState() {
    super.initState();

    var repo = sl.get<ShowRepository>();
    var seasonRepo = sl.get<SeasonRepository>();
    _seasonDetailsBloc =
        SeasonDetailsBloc(slug: slug, seasonRepo: seasonRepo, showRepo: repo);
    _seasonDetailsBloc.dispatch(SeasonDetailsFetchEvent(number: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              primary: true,
              expandedHeight: 500,
              backgroundColor: Theme.of(context).backgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  child: BlocBuilder(
                      bloc: _seasonDetailsBloc,
                      builder: (context, state) {
                        if (state is SeasonDetailsStateLoaded) {
                          return TvShowDetailsAppBar(
                            season: state.data,
                              );
                        } else if (state is SeasonDetailsStateLoading) {
                          return Container(child: CircularProgressIndicator(),);
                        } else {
                          return Container();
                        }
                      }),
                ),
              )),
        ],
      ),
    );
  }
}
