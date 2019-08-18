import 'package:flutter/material.dart';
import 'package:ninjanga3/models/View/episode_poster_view.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TvShowEpisodeRow extends StatelessWidget {
  final EpisodePosterView episode;

  const TvShowEpisodeRow({Key key, this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8.0),
                width: 150.0,
                height: 90.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(episode.poster),
                  ),
                ),
                child: Center(
                  child: Container(
                    height: 32.0,
                    width: 32.0,
                    child: OutlineButton(
                      padding: EdgeInsets.all(0.0),
                      onPressed: () => print('play'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                      ),
                      child: Container(
                        height: 32.0,
                        width: 32.0,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.3),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 24.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${episode.number}. ${episode.title}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                      ),
                    ),
                    SmoothStarRating(
                        allowHalfRating: true,
                        starCount: 10,
                        rating: episode.raiting,
                        size: 15.0,
                        color: Color.fromRGBO(0, 255, 0, 0.8),
                        borderColor: Colors.green,
                        spacing: 0.0),
                    Text(
                      '${episode.duration} min',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(255, 255, 255, 0.3),
                      ),
                    ),
                    Text(
                      episode.overview,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Color.fromRGBO(255, 255, 255, 0.3),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
