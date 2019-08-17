import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ninjanga3/ui/route/routes.dart';

import '../../service_locator.dart';

class HomeButtons extends StatelessWidget {
  final String slug;
  final bool isMovie;

  const HomeButtons({Key key, this.slug, this.isMovie}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      margin: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            textColor: Colors.white,
            child: Column(
              children: <Widget>[
                Icon(Icons.add),
                Text(
                  'Mi lista',
                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            onPressed: () => print('mi lista'),
          ),
          RaisedButton(
              textColor: Colors.black,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Icon(Icons.play_arrow),
                  Text(
                    'Reproducir Trailer',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              onPressed: () =>
                  sl.get<Router>().navigateTo(context,
                    Routes.setVideoRouter(slug, isMovie),
                    transition: TransitionType.inFromBottom,
                    transitionDuration: const Duration(milliseconds: 200),)
          ),
          FlatButton(
            textColor: Colors.white,
            child: Column(
              children: <Widget>[
                Icon(Icons.info_outline),
                Text(
                  'Información',
                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            onPressed: () =>
                sl.get<Router>().navigateTo(
                  context,
                  Routes.setDetailRouter(slug, isMovie),
                  transition: TransitionType.nativeModal,
                  transitionDuration: const Duration(milliseconds: 200),
                )
            ,
          ),
        ],
      ),
    );
  }
}
