import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjanga3/blocs/movie_details/bloc.dart';
import 'package:ninjanga3/blocs/related/bloc.dart';
import 'package:ninjanga3/repositories/movies_repository.dart';

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
  String get movieSlug => widget.slug;
  RelatedBloc _relatedMoviesBloc;
  MovieDetailsBloc _movieDetailsBloc;

  @override
  void initState() {
    super.initState();

    var repo = sl.get<MoviesRepository>();
    _relatedMoviesBloc = RelatedBloc(repo, movieSlug);
    _relatedMoviesBloc.dispatch(FetchRelatedMoviesEvent());

    _movieDetailsBloc = MovieDetailsBloc(movieSlug, repo);
    _movieDetailsBloc.dispatch(MovieDetailsEventFetch());
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
                      bloc: _movieDetailsBloc,
                      builder: (context, state) {
                        if (state is MovieDetailsStateLoaded) {
                          final movie = state.data;
                          return TvShowDetailsAppBar(
                            season: movie,
                          );
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
