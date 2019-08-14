import 'package:flutter/material.dart';

class HomeFeatureTitle extends StatelessWidget {
  final String name;
  final List<String> genres;

  String _formatTitle(String title) {
    List<String> words = title.split(" ");
    if (words.length >= 4) {
      int half = (words.length / 2).round();
      String first = words.take(half).join(" ").trim();
      final newName = first + "\n" + words.skip(half).join(" ").trim();
      return newName;
    } else
      return title;
  }

  const HomeFeatureTitle({Key key, this.genres, this.name}) : super(key: key);

  List<Widget> renderMainGenres() => genres.map((g) {
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

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: 100.0,
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
                _formatTitle(name),
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
    );
  }
}
