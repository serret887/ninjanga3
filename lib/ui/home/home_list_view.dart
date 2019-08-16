import 'package:flutter/material.dart';
import 'package:ninjanga3/models/View/poster_view.dart';
import 'package:ninjanga3/models/home_page_model.dart';
import 'package:ninjanga3/ui/components/movie_scroll_row.dart';

import '../constant_ui.dart';
import 'home_featured_row.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({this.homePageModel});

  final HomePageModel homePageModel;

  Widget renderTypeShowTitle(String tag, String text) {
    return Hero(
      transitionOnUserGestures: true,
      tag: tag,
      child: FlatButton(
        onPressed: () {}, // goTo(tag),//TODO create the routing
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var featuredMovies = homePageModel.getFeaturedMovies() ?? [];
    List<MapEntry<String, List<PosterView>>> allMovieList =
        homePageModel.getAllMovies() ?? [];
    final Size screenSize = MediaQuery.of(context).size;
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        primary: true,
        expandedHeight: screenSize.height * ConstantsUi.expandedHeightAppBar,
        backgroundColor: Colors.black,
        leading: Image.asset('assets/images/netflix_icon.png'),
        titleSpacing: 20.0,
        title: Title(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              renderTypeShowTitle('Series', 'Series'),
              renderTypeShowTitle('Películas', 'Películas'),
              renderTypeShowTitle('Mi-lista', 'Mi lista'),
            ],
          ),
        ),
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          background: HomeFeaturedRow(
            movies: featuredMovies,
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return _buildRowView(allMovieList[index]);
        }, childCount: allMovieList.length),
      ),
    ]);
  }

  Widget _buildRowView(MapEntry<String, List<PosterView>> posters) {
    return Column(children: <Widget>[
      _ListSectionTitleView(title: posters.key),
      Container(
          height: 140.0,
          child: MovieScrollRow(
            key: PageStorageKey(posters.key),
            posters: posters.value,

          )),
    ]);
  }
}

class _ListSectionTitleView extends StatelessWidget {
  final String title;

  const _ListSectionTitleView({Key key, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var button = MaterialButton(
      minWidth: 20,
      child: Image.asset("assets/icons/iconOverflow.png"),
      onPressed: () {
        print(
            "Create route for me for filtering and see all the movies from that category");
//        Navigator.pushNamed(context, MovieCategoryPageArguments.routeName,
//            arguments: MovieCategoryPageArguments(
//                movies: movieList.value, title: movieList.key));
      },
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Text(title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold))),
          Align(alignment: Alignment.centerRight, child: button)
        ],
      ),
    );
  }
}
