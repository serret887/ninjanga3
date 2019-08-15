import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ninjanga3/models/poster_view.dart';
import 'package:ninjanga3/ui/route/routes.dart';

import '../../service_locator.dart';

class PosterItem extends StatelessWidget {
  final PosterView model;

  const PosterItem({Key key, this.model}) : super(key: key);

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
              imageUrl: model.posterImage,
              fit: BoxFit.cover),
          onTap: () {
            sl.get<Router>().navigateTo(
                  context,
                  Routes.setDetailRouter(model.slug, model.isMovie),
                  transition: TransitionType.nativeModal,
                  transitionDuration: const Duration(milliseconds: 200),
                );
          }),
    );
  }
}
