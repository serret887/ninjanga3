import 'package:flutter/material.dart';
import 'package:ninjanga3/models/View/featured_view.dart';

import 'home_buttons.dart';
import 'home_feature.dart';
import 'home_feature_title.dart';

class HomeFeaturedRow extends StatefulWidget {
  final List<FeaturedView> movies;

  const HomeFeaturedRow({Key key, @required this.movies}) : super(key: key);

  @override
  _HomeFeaturedRowState createState() => _HomeFeaturedRowState();
}

class _HomeFeaturedRowState extends State<HomeFeaturedRow>
    with AutomaticKeepAliveClientMixin<HomeFeaturedRow> {
  int _currentPage = 0;
  static const String _pageStorageKey = "_HomeFeaturedRowState";

  _HomeFeaturedRowState();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var pageController = PageController(initialPage: _currentPage);

    var pageView = PageView.builder(
      key: PageStorageKey(_pageStorageKey),
      itemCount: widget.movies.length,
      controller: pageController,
      itemBuilder: (context, index) {
        return _PageItemView(
            movie: widget.movies[index],
            totalPage: widget.movies.length,
            currentPage: index);
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
      Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        HomeFeatureTitle(
          genres: widget.movies[_currentPage].genres,
          name: widget.movies[_currentPage].getTitle(),
        ),
        HomeButtons(
          slug: widget.movies[_currentPage].poster.slug,
          isMovie: widget.movies[_currentPage].poster.isMovie,
        )
      ]),
    ]));
  }

  @override
  bool get wantKeepAlive => true;
}

class _PageItemView extends StatelessWidget {
  final FeaturedView movie;
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
        onTap: () {},
        child: Stack(children: <Widget>[
          HomeFeature(
            imageUrl: movie.getImage(),
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
