import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeFeature extends StatelessWidget {
  final String imageUrl;
  String name;
  final List<String> genres;

  HomeFeature({Key key, this.imageUrl, this.name, this.genres})
      : super(key: key) {
    //TODO I don't like the way the title looks and is trimming words

    List<String> words = this.name.split(" ");
    if (words.length >= 4) {
      int half = (words.length / 2).round();
      String first = words.take(half).join(" ").trim();
      final newName =
          first + "\n" + words.skip(half).join(" ").trim();
      print(newName);
      this.name = newName;
      print(this.name);
    }
  }

  List<Widget> renderMainGenres() {
    return genres.map((g) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          g,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    //TODO I don't like where the moview title lye
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
          child: Container(
            height: 40.0,
            width: screenSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 3.0,
                          color: Color.fromRGBO(185, 3, 12, 1.0),
                        ),
                      ),
                    ),
                    child: Text(
                      name,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 0.85,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: renderMainGenres(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
