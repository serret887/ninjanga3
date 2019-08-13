import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ninjanga3/models/movie_view.dart';


class PageItemView extends StatelessWidget {
  final MovieView movie;
  final int totalPage;
  final int currentPage;

  const PageItemView({Key key,
    this.movie,
    this.totalPage,
    this.currentPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: CachedNetworkImage(
              imageUrl: movie.backdrop, fit: BoxFit.cover)),
      Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87])),
          )),
      Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        movie.title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
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
    ]);
  }
}
