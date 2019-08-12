import 'package:flutter/material.dart';
import 'package:ninjanga3/models/home_page_model.dart';
import 'package:ninjanga3/models/movie_view.dart';
import 'package:ninjanga3/ui/category_page/category_page.dart';
import 'package:ninjanga3/ui/components/movie_scroll_row.dart';

import 'home_featured_row.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({this.homePageModel});
  final HomePageModel homePageModel;
  @override
  Widget build(BuildContext context) {
    List<MovieView> featuredMovies = homePageModel.getFeaturedMovies() ?? [];
    List<MapEntry<String, List<MovieView>>> allMovieList =
        homePageModel.getAllMovies() ?? [];

    return Container(
        color: Color(0xff26262d),
        child: CustomScrollView(slivers: <Widget>[
          _buildAppBar(
              featuredMovies: featuredMovies,
              height: MediaQuery.of(context).size.width * 0.6),
          SliverFixedExtentList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return _buildRowView(allMovieList[index]);
              }, childCount: allMovieList.length),
              itemExtent: 303),
        ]));
  }

  Widget _buildRowView(MapEntry<String, List<MovieView>> movieList) {
    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: _ListSectionTitleView(movieList: movieList)),
      Container(
          height: 250,
          child: MovieScrollRow(
            key: PageStorageKey(movieList.key),
            movies: movieList.value,
          )),
      Container(
        height: 1,
        child: Divider(color: Colors.white24),
      )
    ]);
  }

  Widget _buildAppBar({List<MovieView> featuredMovies, double height}) {
    return SliverAppBar(
      title: FlatButton.icon(
        color: Colors.white,
        onPressed: null,
        icon: Icon(
          Icons.movie,
          color: Colors.white,
        ),
        label: Text("Ninjanga",
            style: TextStyle(fontSize: 30, color: Colors.white)),
      ),
      pinned: true,
      backgroundColor: Color(0xff26262d),
      expandedHeight: height,
      flexibleSpace: FlexibleSpaceBar(
          background: Center(
        child: FlexibleSpaceBar(
            background: HomeFeaturedRow(movies: featuredMovies)),
      )),
      //  HomeFeaturedRow(movies: featuredMovies)),
    );
  }
}

class _ListSectionTitleView extends StatelessWidget {
  final MapEntry<String, List<MovieView>> movieList;

  const _ListSectionTitleView({Key key, @required this.movieList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var button = MaterialButton(
      minWidth: 20,
      child: Image.asset("assets/icons/iconOverflow.png"),
      onPressed: () {
        Navigator.pushNamed(context, MovieCategoryPageArguments.routeName,
            arguments: MovieCategoryPageArguments(
                movies: movieList.value, title: movieList.key));
      },
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 52,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Text(movieList.key,
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
