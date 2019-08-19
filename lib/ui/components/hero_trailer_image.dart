import 'package:flutter/material.dart';
import 'package:ninjanga3/ui/route/route_commands.dart';

class HeroTrailerImage extends StatelessWidget {
  final String backdrop;
  final String slug;
  final bool isMovie;

  const HeroTrailerImage(
      {Key key,
      @required this.backdrop,
      @required this.slug,
      @required this.isMovie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: screenSize.height * .40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            stops: [0.1, 0.4, 1.0],
            colors: [Colors.black54, Colors.transparent, Colors.black],
          ),
        ),
        child: Center(
          child: Container(
            height: 64.0,
            width: 64.0,
            child: OutlineButton(
              padding: EdgeInsets.all(0.0),
              onPressed: () => RouteCommands.goToVideoPlayer(
                  context: context, slug: slug, isMovie: isMovie),
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
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            backdrop,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
