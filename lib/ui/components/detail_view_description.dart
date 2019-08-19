import 'package:flutter/material.dart';
import 'package:ninjanga3/models/View/detail_description_view.dart';

import 'details_button_control.dart';
import 'details_description.dart';
import 'hero_trailer_image.dart';

class DetailDescription extends StatelessWidget {
  final DetailDescriptionView movie;

  const DetailDescription({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          fit: StackFit.loose,
          children: <Widget>[
            HeroTrailerImage(
              backdrop: movie.backdrop,
              slug: movie.ids.slug,
              isMovie: movie.isMovie,
            ),
            DetailsDescription(
              certification: movie.certification,
              duration: movie.duration,
              overview: movie.getOverView(),
              rating: movie.rating,
              title: movie.getTitle(),
              year: movie.year,
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: DetailButtonControl(),
        ),
      ],
    );
  }
}
