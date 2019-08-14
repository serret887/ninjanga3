import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ninjanga3/ui/route/routes.dart';

import '../../service_locator.dart';

class PosterItem extends StatelessWidget {
  final String posterImage;
  final String slug;
  final double rating;
  final bool isMovie;

  const PosterItem(
      {Key key, this.posterImage, this.slug, this.rating, this.isMovie})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 6.0),
      child: GestureDetector(
          child: CachedNetworkImage(
              placeholder: (context, url) {
                return AspectRatio(
                    aspectRatio: .68,
                    child: Image.asset("assets/icons/placeholder.png",
                        fit: BoxFit.cover));
              },
              imageUrl: posterImage,
              fit: BoxFit.cover),
          onTap: () {
            sl.get<Router>().navigateTo(
                  context,
              Routes.setDetailRouter(slug, isMovie),
                  transition: TransitionType.nativeModal,
                  transitionDuration: const Duration(milliseconds: 200),
                );
          }),
    );
  }
}
