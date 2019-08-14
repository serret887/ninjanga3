import 'package:flutter/material.dart';

class TvShowDetails extends StatefulWidget {
  final String slug;

  const TvShowDetails({Key key, this.slug}) : super(key: key);

  @override
  _TvShowDetailsState createState() => _TvShowDetailsState();
}

class _TvShowDetailsState extends State<TvShowDetails> {
  String get slug => widget.slug;


  @override
  Widget build(BuildContext context) {
    return Container(child: Text(slug),);
  }
}
