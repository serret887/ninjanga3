import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjanga3/blocs/movie_details/bloc.dart';
import 'package:ninjanga3/blocs/related/bloc.dart';
import 'package:ninjanga3/models/movie_view.dart';
import 'package:ninjanga3/repositories/movies_repository.dart';
import 'package:ninjanga3/repositories/related_repository.dart';
import 'package:ninjanga3/ui/components/movie_scroll_row.dart';

import '../../service_locator.dart';


class MovieDetailsPage extends StatefulWidget {
  final String movieSlug;

  const MovieDetailsPage({Key key, @required this.movieSlug}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MovieDetailsPageState();
  }
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  String get movieSlug => widget.movieSlug;
  RelatedBloc _relatedMoviesBloc;
  MovieDetailsBloc _movieDetailsBloc;

  @override
  void initState() {
    super.initState();

    var repo = sl.get<RelatedRepository>();
    _relatedMoviesBloc = RelatedBloc(repo, movieSlug);
    _relatedMoviesBloc.dispatch(FetchRelatedMoviesEvent());

    var moviesRepository = sl.get<MoviesRepository>();
    _movieDetailsBloc = MovieDetailsBloc(movieSlug, moviesRepository);
    _movieDetailsBloc.dispatch(MovieDetailsEventFetch());
  }

  @override
  Widget build(BuildContext context) {
    var topImageHeight = MediaQuery.of(context).size.width * 0.7;

    return BlocBuilder(
        bloc: _movieDetailsBloc,
        builder: (context, state) {
          if (state is MovieDetailsStateLoaded) {
            final isPortraitMode =
                MediaQuery
                    .of(context)
                    .orientation == Orientation.portrait;
            final movie = state.data;
            return Scaffold(
                backgroundColor: Color(0xff26262d),
                appBar: AppBar(
                  backgroundColor: Color(0xff26262d),
                  title: Text('${movie.title}'),
                ),
                body: SafeArea(
                    child: Stack(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.topCenter,
                            child: _buildImageView(
                                context: context, height: topImageHeight
                                , imageUrl: movie.backdrop
                            )),
                        SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height,
                            child: ListView(
                              padding: EdgeInsets.only(
                                  top:
                                  isPortraitMode ? (topImageHeight - 160) : 30),
                              children: <Widget>[
                                _buildInfoRow(context, movie),
                                _buildControlsRow(context),
                                Container(
                                  child: _buildTrailerRow(context),
                                ),
                                BlocBuilder(
                                  bloc: _relatedMoviesBloc,
                                  builder: (BuildContext context, state) {
                                    return Container(
                                      child: _buildRelatedRow(state: state),
                                    );
                                  },
                                )
                              ],
                            ))
                      ],
                    )));
          } else if (state is MovieDetailsStateLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailsStateError) {
            return Container(
              child: Center(
                child: Text("There was an error loading the movie details"),
              ),
            );
          } else {
            return Container(
              child: Center(
                child: Text('this is not good $state'),
              ),
            );
          }
        });
  }

  Widget _buildImageView(
      {BuildContext context, double height, String imageUrl}) {
    return SizedBox(
        child: Stack(children: <Widget>[
      Container(
          height: height,
          width: MediaQuery.of(context).size.width,
          child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) {
                return Center(
                    child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.grey))));
              },
              fit: BoxFit.cover)),
      SizedBox.expand(
          child: Container(
              height: 300,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      stops: [0.5, 1.0],
                      colors: [Colors.black38, Color(0xff26262d)])))),
    ]));
  }

  Widget _buildInfoRow(BuildContext context, MovieView movie) {
    return Container(
        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                    width: 124,
                    height: 180,
                    child: CachedNetworkImage(
                        imageUrl: movie.posterImage, fit: BoxFit.cover)),
                SizedBox(width: 10),
                SizedBox(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('${movie.title}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 26)),
                        SizedBox(height: 30),
                        (movie.year > 0
                            ? Text(
                            '(${movie.year}) · ${movie.duration}\n${movie.genres
                                ?.join()} ',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12))
                            : Text(''))
                      ],
                    )),
              ],
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: _ratingText(movie.certification))
          ],
        ));
  }

  Widget _buildControlsRow(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(children: <Widget>[
                SizedBox(
                    width: 60,
                    height: 60,
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset("assets/icons/add_to_queue_normal.png"),
                    )),
                Text('My Queue', style: TextStyle(fontSize: 12)),
              ]),
              SizedBox(
                  width: 100,
                  height: 100,
                  child: IconButton(
                    onPressed: () {
                      final currentState = this._movieDetailsBloc.currentState;
                      if (currentState is MovieDetailsStateLoading) {
                        _showAlertDialog(context,
                            title: 'Loading',
                            message:
                                'Movie content is loading. Please try again later.');
                      }

                      if (currentState is MovieDetailsStateError) {
                        _showAlertDialog(context,
                            title: 'Error',
                            message: currentState.error.toString());
                      }

                      if (currentState is MovieDetailsStateLoaded) {
                        var theMovie = currentState.data;

                        _showAlertDialog(context,
                            title: 'Playing',
                            message:
                                'This is to play a movie i need to figure out how to');
                        // if (theMovie.videoResources.isNotEmpty &&
                        //     theMovie.videoResources[0].manifest.url != null) {
                        //   Navigator.of(context, rootNavigator: true).pushNamed(
                        //       VideoPlayerPageArguments.routeName,
                        //       arguments: VideoPlayerPageArguments(
                        //           movie: theMovie,
                        //           url:
                        //               theMovie.videoResources[0].manifest.url));
                      } else {
                        _showAlertDialog(context,
                            title: 'Error',
                            message: 'Error loading movie resource.');
                      }
                    },
                    //TODO i change this from the image icon_share_normal
                    icon: Icon(Icons.share),
                  )),
              Column(
                children: <Widget>[
                  SizedBox(
                      width: 60,
                      height: 60,
                      child: IconButton(
                        onPressed: () {},
                        icon: Image.asset("assets/icons/share_normal.png"),
                      )),
                  Text('Share', style: TextStyle(fontSize: 12)),
                ],
              )
            ]));
  }

  Widget _buildTrailerRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'I need to put here a video player',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'I need to put here a video player',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _ratingText(String value) {
    return (value == null)
        ? null
        : ClipRRect(
        borderRadius: BorderRadius.circular(2.0),
        child: Container(
            color: Color(0xff474747),
            child: Padding(
                padding: EdgeInsets.all(6),
                child: Text(
                  value,
                  style:
                  TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ))));
  }

  Widget _buildRelatedRow({@required RelatedState state}) {
    if (state is RelatedLoaded) {
      if (state.movies.isEmpty) {
        return Container();
      }
      return Column(children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text('You May Also Like',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 20),
            height: 270,
            child: MovieScrollRow(movies: state.movies, key: UniqueKey()))
      ]);
    }

    if (state is RelatedError) {
      return Container();
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

  _showAlertDialog(BuildContext context, {String title, String message}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(message),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _relatedMoviesBloc.dispose();
    _movieDetailsBloc.dispose();
  }
}
