import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:ninjanga3/models/View/poster_view.dart';
import 'package:ninjanga3/ui/components/poster_item.dart';

class MovieScrollRow extends StatelessWidget {
  final List<PosterView> posters;

  const MovieScrollRow({@required Key key, @required this.posters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            key: key,
            itemCount: posters.length,
            itemBuilder: (context, index) {
              return PosterItem(model: posters[index]);
            },
            padding: EdgeInsets.only(left: 14.0),
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics()));
  }
}
