import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DetailsDescription extends StatelessWidget {
  final String title;
  final String overview;
  final int duration;
  final double rating;
  final int year;
  final String certification;

  const DetailsDescription(
      {Key key,
      @required this.title,
      @required this.overview,
      @required this.duration,
      @required this.rating,
      @required this.year,
      @required this.certification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(children: <Widget>[
      Container(
        width: screenSize.width,
        height: 320,
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
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
      Container(
        padding: EdgeInsets.only(left: 8.0, right: 30.0),
        width: screenSize.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SmoothStarRating(
                allowHalfRating: false,
                starCount: 10,
                rating: rating,
                size: 15.0,
                color: Color.fromRGBO(0, 255, 0, 0.8),
                borderColor: Colors.green,
                spacing: 0.0),
            Text(
              '$duration min',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.3),
                fontWeight: FontWeight.w400,
                fontSize: 12.0,
              ),
            ),
            Text(
              'year: $year',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.3),
                fontWeight: FontWeight.w400,
                fontSize: 12.0,
              ),
            ),
            _ratingText(certification)
          ],
        ),
      ),
      Container(
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
                      overview,
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
              ]))
    ]);
  }

  Widget _ratingText(String value) => (value == null)
      ? Container()
      : ClipRRect(
          borderRadius: BorderRadius.circular(2.0),
          child: Container(
              color: Color(0xff474747),
              child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Text(
                    value,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ))));
}
