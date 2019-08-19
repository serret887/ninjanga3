import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  final List<String> values;
  final Function dispatch;
  final String initialValue;

  const DropDownMenu({Key key, this.values, this.dispatch, this.initialValue})
      : super(key: key);

  @override
  _DropDownMenuState createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String currentValue;
  initState() {
    currentValue = widget.initialValue;
    super.initState();
  }

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

  List<DropdownMenuItem<String>> generateDropdownMenuItem() => widget.values
      .map<DropdownMenuItem<String>>((val) => DropdownMenuItem(
            child: generateItem(val),
            value: val,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    if (widget.values.length == 0) return Container();
    if (widget.values.length == 1) return generateItem(widget.values[0]);
    var theme = Theme.of(context);
    //TODO the color of the dropdown is not entirely black
    return DropdownButton<String>(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Color.fromRGBO(255, 255, 255, 0.6),
        ),
        value: currentValue,
        items: generateDropdownMenuItem(),
        onChanged: (String newValue) {
          setState(() {
            currentValue = newValue;
          });
          widget.dispatch(newValue);
        });
  }
}
