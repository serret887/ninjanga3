import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ninjanga3/models/View/seasonView.dart';
import 'package:ninjanga3/ui/route/routes.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../service_locator.dart';

class TvShowDetailsAppBar extends StatefulWidget {
  final SeasonView season;

  const TvShowDetailsAppBar({Key key, this.season}) : super(key: key);

  @override
  _TvShowDetailsAppBarState createState() => _TvShowDetailsAppBarState();
}

class _TvShowDetailsAppBarState extends State<TvShowDetailsAppBar> {
  bool _showOverview = false;
  SeasonView get season => widget.season;

  toggleOverview() => setState(() {
        _showOverview = !_showOverview;
      });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.loose,
      children: <Widget>[
        Container(
          width: screenSize.width,
          height: 320,
          child: Center(
            child: Container(
              height: 64.0,
              width: 64.0,
              child: OutlineButton(
                padding: EdgeInsets.all(0.0),
                onPressed: () => print("hashdflasldfhlahsdflashdf"),
//                    sl.get<Router>().navigateTo(
//                      context,
//                      Routes.setVideoRouter(season.ids.slug, false),
//                      transition: TransitionType.fadeIn,
//                      transitionDuration: const Duration(milliseconds: 500),
//                    ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                ),
                child: Container(
                  height: 64.0,
                  width: 64.0,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 48.0,
                  ),
                ),
              ),
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                season.backdrop,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: screenSize.width,
          height: 320,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                stops: [0.1, 0.4, 1.0],
                colors: [Colors.black54, Colors.transparent, Colors.black],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    season.title,
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 320,
          child: Container(
            padding: EdgeInsets.only(left: 8.0, right: 30.0),
            width: screenSize.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SmoothStarRating(
                    allowHalfRating: true,
                    starCount: 10,
                    rating: season.rating,
                    size: 15.0,
                    color: Color.fromRGBO(0, 255, 0, 0.8),
                    borderColor: Colors.green,
                    spacing: 0.0),
                Text(
                  '${season.duration} min',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.3),
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  'year: ${season.year}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.3),
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                  ),
                ),
                _ratingText(season.certification)
              ],
            ),
          ),
        ),
        Positioned(
          top: 355,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            width: screenSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: toggleOverview,
                    child: Text(
                      season.overview,
                      overflow: _showOverview ? null : TextOverflow.ellipsis,
                      maxLines: _showOverview ? null : 3,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Container(
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.3),
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Protagonizada por: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: "I need to create the cast list"),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      FlatButton(
                        textColor: Colors.white70,
                        onPressed: () => print('Mi Lista'),
                        child: Container(
                          height: 50.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(
                                Icons.add,
                                size: 32.0,
                              ),
                              Text(
                                'Add',
                                style: TextStyle(fontSize: 10.0),
                              )
                            ],
                          ),
                        ),
                      ),
                      FlatButton(
                        textColor: Colors.white70,
                        onPressed: () => print('Not watched'),
                        child: Container(
                          height: 50.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(
                                Icons.visibility,
                                size: 24.0,
                              ),
                              Text(
                                'Not watched',
                                style: TextStyle(fontSize: 10.0),
                              )
                            ],
                          ),
                        ),
                      ),
                      FlatButton(
                        textColor: Colors.white70,
                        onPressed: () => print('Compartir'),
                        child: Container(
                          height: 50.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(
                                Icons.share,
                                size: 20.0,
                              ),
                              Text(
                                'Compartir',
                                style: TextStyle(fontSize: 10.0),
                              )
                            ],
                          ),
                        ),
                      ),
                      FlatButton(
                        textColor: Colors.white70,
                        onPressed: () => print('Descargar'),
                        child: Container(
                          height: 50.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(
                                Icons.file_download,
                                size: 20.0,
                              ),
                              Text(
                                'Descargar',
                                style: TextStyle(fontSize: 10.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Container(
                    child: Text(
                      'EPISODIOS',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: season.seasonAmount > 1
                      ? () => print('cambiando temporada')
                      : null,
                  child: Row(
                    children: <Widget>[
                      (season.seasonAmount == 1
                          ? Text(
                              'Temporada ${season.number}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                              ),
                            )
                          : DropdownButton<String>(
                              value: 'Temporada ${season.number}',
                              onChanged: (String newValue) =>
                                  sl.get<Router>().navigateTo(
                                        context,
                                        Routes.setDetailRouter(
                                            season.ids.slug, false),
                                        transition: TransitionType.nativeModal,
                                        transitionDuration:
                                            const Duration(milliseconds: 200),
                                      ))),
//
//                          ? Padding(
//                              padding: EdgeInsets.only(left: 8.0),
//                              child: Icon(
//                                Icons.arrow_drop_down,
//                                color: Color.fromRGBO(255, 255, 255, 0.6),
//                              ),
//                            )
//                          : Container())
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
}
