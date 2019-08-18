import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjanga3/blocs/season_details/bloc.dart';
import 'package:ninjanga3/blocs/season_episodes/bloc.dart';
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
  SeasonEpisodeBloc _seasonEpisodeBloc;

  String get slug => widget.slug;
  SeasonDetailsBloc _seasonDetailsBloc;
  @override
  void initState() {
    super.initState();

    var repo = sl.get<ShowRepository>();
    _seasonDetailsBloc = SeasonDetailsBloc(slug: slug, showRepo: repo);
    _seasonDetailsBloc.dispatch(SeasonDetailsFetchEvent(number: widget.season));

    _seasonEpisodeBloc = SeasonEpisodeBloc(repository: repo, slug: slug);
    _seasonEpisodeBloc.dispatch(FetchSeasonEpisodesEvent(1));
  }

  dispatchSeasonChange(String val) {
    final intRegex = RegExp(r'\s+(\d+)\s+', multiLine: true);
    var n2umber = intRegex.firstMatch(val);
    int number = 3;

    _seasonEpisodeBloc.dispatch(FetchSeasonEpisodesEvent(number));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
              primary: true,
              expandedHeight: 530,
              backgroundColor: Theme.of(context).backgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                      child: BlocBuilder(
                          bloc: _seasonDetailsBloc,
                          builder: (context, state) {
                            if (state is SeasonDetailsSummaryStateLoaded)
                              return TvShowDetailsAppBar(
                                season: state.data,
                                dispatchSeasonChange: dispatchSeasonChange,
                              );
                            else if (state is SeasonDetailsStateLoading) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return Container(
                                child: Center(
                                  child: Text(
                                      "We had an error loading the details of the show, try later"),
                                ),
                              );
                            }
                          })))),
          BlocBuilder(
              bloc: _seasonEpisodeBloc,
              builder: (BuildContext context, state) {
                if (state is SeasonEpisodeLoaded)
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            TvShowEpisodeRow(episode: state.episodes[index]),
                        childCount: state.episodes.length),
                  );
                else if (state is SeasonEpisodesLoading) {
                  return SliverToBoxAdapter(
                      child: Center(
                    child: CircularProgressIndicator(),
                  ));
                } else {
                  return SliverToBoxAdapter(
                      child: Container(
                    child: Center(
                      child:
                          Text("We had an error loading episodes, try later"),
                    ),
                  ));
                }
              })
        ]));
  }
}
