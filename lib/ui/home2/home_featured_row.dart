import 'package:flutter/material.dart';
import 'package:ninjanga3/models/movie_view.dart';

import 'home_buttons.dart';
import 'home_feature.dart';

class HomeFeaturedRow extends StatefulWidget {
  final List<MovieView> movies;

  const HomeFeaturedRow({Key key, @required this.movies}) : super(key: key);

  @override
  _HomeFeaturedRowState createState() => _HomeFeaturedRowState(this.movies);
}

class _HomeFeaturedRowState extends State<HomeFeaturedRow>
    with AutomaticKeepAliveClientMixin<HomeFeaturedRow> {
  final List<MovieView> movies;
  int _currentPage = 0;
  static const String _pageStorageKey = "_HomeFeaturedRowState";

  _HomeFeaturedRowState(this.movies);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var pageController = PageController(initialPage: _currentPage);

    var pageView = PageView.builder(
      key: PageStorageKey(_pageStorageKey),
      itemCount: movies.length,
      controller: pageController,
      itemBuilder: (context, index) {
        return _PageItemView(
            movie: movies[index], totalPage: movies.length, currentPage: index);
      },
      onPageChanged: (page) {
        setState(() {
          this._currentPage = page;
        });
      },
    );

    return Container(
        child: Stack(children: <Widget>[
      pageView,
          Column(mainAxisAlignment: MainAxisAlignment.end,

              children: <Widget>[
                HomeButtons(
          slug: movies[_currentPage].ids.slug,
        )
      ]),
    ]));
  }

  @override
  bool get wantKeepAlive => true;
}

class _PageItemView extends StatelessWidget {
  final MovieView movie;
  final int totalPage;
  final int currentPage;

  const _PageItemView(
      {Key key,
      @required this.movie,
      @required this.totalPage,
      @required this.currentPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
//          Navigator.pushNamed(context, MovieDetailsPageArguments.routeName,
//              arguments: MovieDetailsPageArguments(movie));
        },
        child: Stack(children: <Widget>[
          HomeFeature(
            imageUrl: movie.backdrop,
            genres: movie.genres,
            name: movie.title,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: Stack(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.bottomRight,
                          child: RichText(
                              text: TextSpan(
                            text: '${currentPage + 1}',
                            style: TextStyle(
                                color: Color(0xffee5c32), fontSize: 12),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' / $totalPage',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12))
                            ],
                          ))),
                    ],
                  )))
        ]));
  }
}
