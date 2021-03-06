import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjanga3/blocs/movie_details/bloc.dart';
import 'package:ninjanga3/blocs/related/bloc.dart';
import 'package:ninjanga3/repositories/movies_repository.dart';
import 'package:ninjanga3/ui/components/detail_view_description.dart';
import 'package:ninjanga3/ui/components/movie_scroll_row.dart';

import '../../service_locator.dart';

class MovieDetails extends StatefulWidget {
  final String slug;

  const MovieDetails({
    Key key,
    this.slug,
  }) : super(key: key);
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  String get movieSlug => widget.slug;
  RelatedBloc _relatedMoviesBloc;
  MovieDetailsBloc _movieDetailsBloc;

  @override
  void initState() {
    super.initState();

    var repo = sl.get<MoviesRepository>();
    _relatedMoviesBloc = RelatedBloc(movieSlug, repo);
    _relatedMoviesBloc.dispatch(FetchRelatedEvent(true));

    _movieDetailsBloc = MovieDetailsBloc(movieSlug, repo);
    _movieDetailsBloc.dispatch(MovieDetailsEventFetch());
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              primary: true,
              expandedHeight: screenSize.height * .6,
              backgroundColor: Theme.of(context).backgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  child: BlocBuilder(
                      bloc: _movieDetailsBloc,
                      builder: (context, state) {
                        if (state is MovieDetailsStateLoaded) {
                          final movie = state.data;
                          return DetailDescription(
                            movie: movie,
                          );
                        } else {
                          return Container();
                        }
                      }),
                ),
              )),
          SliverToBoxAdapter(
              child: BlocBuilder(
            bloc: _relatedMoviesBloc,
            builder: (BuildContext context, state) {
              return Container(
                child: _buildRelatedRow(state: state),
              );
            },
          )),
        ],
      ),
    );
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
