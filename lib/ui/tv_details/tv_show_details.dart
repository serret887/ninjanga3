import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjanga3/blocs/season_details/bloc.dart';
import 'package:ninjanga3/repositories/show_repository.dart';

import '../../service_locator.dart';
import 'tv_show_details_app_bar.dart';
import 'tv_show_episode_row.dart';

class TvShowDetails extends StatefulWidget {
  final String slug;
  final int season;

  const TvShowDetails({Key key, this.slug, this.season}) : super(key: key);

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
    _seasonDetailsBloc = SeasonDetailsBloc(slug: slug, showRepo: repo);
    _seasonDetailsBloc.dispatch(SeasonDetailsFetchEvent(number: widget.season));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: BlocBuilder(
            bloc: _seasonDetailsBloc,
            builder: (context, state) {
              if (state is SeasonDetailsStateLoaded) {
                return CustomScrollView(slivers: <Widget>[
                  SliverAppBar(
                      primary: true,
                      expandedHeight: 550,
                      backgroundColor: Theme.of(context).backgroundColor,
                      flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Container(
                              child: TvShowDetailsAppBar(
                            season: state.data,
                          )))),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => TvShowEpisodeRow(
                            episode: state.data.episodesPosterView[index]),
                        childCount: state.data.episodesPosterView.length),
                  ),
                ]);
              } else if (state is SeasonDetailsStateLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container(
                  child: Center(
                    child: Text("We had an error try later"),
                  ),
                );
              }
            }));
  }
}
