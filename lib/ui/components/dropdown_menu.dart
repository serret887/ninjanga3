import 'package:flutter/material.dart';

class DropDownMenu extends StatelessWidget {
  final List<String> values;
  final Function dispatch;
  final String currentValue;

  const DropDownMenu(
      {Key key,
      @required this.values,
      @required this.dispatch,
      @required this.currentValue})
      : super(key: key);

  generateItem(String text) => Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.6),
          fontWeight: FontWeight.w500,
          fontSize: 15.0,
        ),
      );

  List<DropdownMenuItem<String>> generateDropdownMenuItem() => values
      .map<DropdownMenuItem<String>>((val) => DropdownMenuItem(
            child: generateItem(val),
            value: val,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    if (values.length == 0) return Container();
    if (values.length == 1) return generateItem(values[0]);
    var theme = Theme.of(context);
    //TODO the color of the dropdown is not entirely black
    return DropdownButton<String>(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Color.fromRGBO(255, 255, 255, 0.6),
        ),
        value: currentValue,
        items: generateDropdownMenuItem(),
        onChanged: (String newValue) => dispatch(newValue));
  }
}
