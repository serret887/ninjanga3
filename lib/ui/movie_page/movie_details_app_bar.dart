import 'package:flutter/material.dart';
import 'package:ninjanga3/models/movie_view.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MovieDetailsAppBar extends StatelessWidget {
  final MovieView movie;

  const MovieDetailsAppBar({Key key, this.movie}) : super(key: key);
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
                onPressed: () => print('play'),
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
                movie.backdrop,
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
                    movie.title,
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
                    allowHalfRating: false,
                    starCount: 10,
                    rating: movie.rating,
                    size: 15.0,
                    color: Color.fromRGBO(0, 255, 0, 0.8),
                    borderColor: Colors.green,
                    spacing: 0.0),
                Text(
                  'year: ${movie.year}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.3),
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  '${movie.duration} min',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.3),
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                  ),
                ),
                _ratingText(movie.certification)
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
                  child: Container(
                    child: Text(
                      movie.overview,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
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
                                'Mi Lista',
                                style: TextStyle(fontSize: 10.0),
                              )
                            ],
                          ),
                        ),
                      ),
                      FlatButton(
                        textColor: Colors.white70,
                        onPressed: () => print('calificar'),
                        child: Container(
                          height: 50.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(
                                Icons.thumb_up,
                                size: 24.0,
                              ),
                              Text(
                                'Calificar',
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
