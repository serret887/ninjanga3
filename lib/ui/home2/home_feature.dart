import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeFeature extends StatelessWidget {
  final String imageUrl;

  HomeFeature({
    Key key,
    this.imageUrl,
  }) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              stops: [0.1, 0.5, 1.0],
              colors: [Colors.black54, Colors.transparent, Colors.black],
            ),
          ),
        ),
      ],
    );
  }
}
