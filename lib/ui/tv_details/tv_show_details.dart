import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjanga3/blocs/related/bloc.dart';
import 'package:ninjanga3/blocs/season_details/bloc.dart';
import 'package:ninjanga3/blocs/season_episodes/bloc.dart';
import 'package:ninjanga3/repositories/show_repository.dart';
import 'package:ninjanga3/ui/components/movie_scroll_row.dart';

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

  RelatedBloc _relatedBloc;

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

    _relatedBloc = RelatedBloc(slug, null, repo);
    _relatedBloc.dispatch(FetchRelatedEvent(false));
  }

  dispatchSeasonChange(String val) {
    int number = int.parse(val.split(" ")[1]);
    _seasonEpisodeBloc.dispatch(FetchSeasonEpisodesEvent(number));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
              primary: true,
              expandedHeight: screenSize.height * .65,
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
                  return SliverFillRemaining(
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
              }),
          BlocBuilder(
              bloc: _relatedBloc,
              builder: (BuildContext context, state) {
                return SliverToBoxAdapter(
                  child: _buildRelatedRow(state: state),
                );
              })
        ]));
  }

  Widget _buildRelatedRow({@required RelatedState state}) {
    if (state is RelatedLoaded) {
      if (state.movies.isEmpty) {
        return Container();
      }
      var posters = state.movies;
      return Column(children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text('You May Also Like',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 20),
            height: 200,
            child: MovieScrollRow(posters: posters, key: UniqueKey()))
      ]);
    }

    if (state is RelatedError) {
      return Container(
        child: Center(
          child: Text(
            "There was an error loading related titles try later",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
            child: Container(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))));
  }
}
