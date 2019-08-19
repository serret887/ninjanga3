import 'package:flutter/material.dart';
import 'package:ninjanga3/models/View/seasonView.dart';
import 'package:ninjanga3/ui/components/detail_view_description.dart';
import 'package:ninjanga3/ui/components/dropdown_menu.dart';

class TvShowDetailsAppBar extends StatefulWidget {
  final SeasonView season;
  final Function dispatchSeasonChange;

  const TvShowDetailsAppBar(
      {Key key, @required this.season, @required this.dispatchSeasonChange})
      : super(key: key);

  @override
  _TvShowDetailsAppBarState createState() => _TvShowDetailsAppBarState();
}

class _TvShowDetailsAppBarState extends State<TvShowDetailsAppBar> {
  bool _showOverview = false;
  SeasonView get season => widget.season;
  Function get dispatchSeasonChange => widget.dispatchSeasonChange;

  toggleOverview() => setState(() {
        _showOverview = !_showOverview;
      });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        DetailDescription(
          movie: season.descriptionView,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: createSeasonRow(),
        )
      ],
    );
  }

  createSeasonRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              child: Text(
                'EPISODIOS',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: DropDownMenu(
                initialValue: seasonNameConstructor(season.number),
                dispatch: dispatchSeasonChange,
                values: Iterable<String>.generate(season.getSeasonAmount(),
                    (number) => seasonNameConstructor(number + 1)).toList(),
              )),
        ],
      );

  String seasonNameConstructor(int number) => 'Temporada $number';

  Widget _ratingText(String value) {
    return (value == null)
        ? null
        : ClipRRect(
            borderRadius: BorderRadius.circular(2.0),
            child: Container(
                color: Color(0xff474747),
                child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Text(
                      value,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    ))));
  }
}
