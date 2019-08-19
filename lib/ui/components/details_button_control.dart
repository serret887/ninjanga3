import 'package:flutter/material.dart';

class DetailButtonControl extends StatelessWidget {
  //TODO add controls functionality
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          FlatButton(
            textColor: Colors.white70,
            onPressed: () => print('Mi Lista'),
            child: Container(
              height: 50.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    size: 32.0,
                  ),
                  Text(
                    'Add',
                    style: TextStyle(fontSize: 10.0),
                  )
                ],
              ),
            ),
          ),
          FlatButton(
            textColor: Colors.white70,
            onPressed: () => print('Not watched'),
            child: Container(
              height: 50.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.visibility,
                    size: 24.0,
                  ),
                  Text(
                    'Not watched',
                    style: TextStyle(fontSize: 10.0),
                  )
                ],
              ),
            ),
          ),
          FlatButton(
            textColor: Colors.white70,
            onPressed: () => print('Compartir'),
            child: Container(
              height: 50.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.share,
                    size: 20.0,
                  ),
                  Text(
                    'Compartir',
                    style: TextStyle(fontSize: 10.0),
                  )
                ],
              ),
            ),
          ),
          FlatButton(
            textColor: Colors.white70,
            onPressed: () => print('Descargar'),
            child: Container(
              height: 50.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.file_download,
                    size: 20.0,
                  ),
                  Text(
                    'Descargar',
                    style: TextStyle(fontSize: 10.0),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
