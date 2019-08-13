import 'package:flutter/material.dart';

class HomeControll extends StatelessWidget {
  final String slug;

  const HomeControll({Key key, this.slug}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
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
                  'Reproducir',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            onPressed: () {
              print("I need to show trailer");
            },
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
            onPressed: () => print("Go to the show page detail"),
          ),
        ],
      ),
    );
  }
}
